Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVBQRdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVBQRdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 12:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVBQRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 12:32:37 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:23675 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262313AbVBQRbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 12:31:19 -0500
Date: Thu, 17 Feb 2005 09:31:01 -0800
From: Greg KH <gregkh@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PHYSDEVDRIVER=<NULL>
Message-ID: <20050217173100.GA10786@suse.de>
References: <20050217140858.GA32212@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217140858.GA32212@suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 03:08:58PM +0100, Olaf Hering wrote:
> 
> For some reasons, PHYSDEVDRIVER can be <NULL> for block events.
> So just check for that.

That's odd.  Any idea what driver causes this?  A bus should always have
a name associated with it.  I'd rather fix the broken bus driver.

thanks,

greg k-h
