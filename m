Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVC0DRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVC0DRP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 22:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVC0DRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 22:17:15 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:5078 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261423AbVC0DRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 22:17:13 -0500
Date: Sat, 26 Mar 2005 19:16:57 -0800
From: Greg KH <gregkh@suse.de>
To: Sheshka Alexey <sheshka.a@extmedia.com>
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com
Subject: Re: Possible XFS bug on 2.6.11.5
Message-ID: <20050327031657.GA31348@suse.de>
References: <4245BF57.1080907@extmedia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4245BF57.1080907@extmedia.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 10:00:23PM +0200, Sheshka Alexey wrote:
> Hi!
> 
> I've got 100% reproduceble on my system (Toshiba A75) Oops on 2.6.11.5 
> (2.6.11 with same options works fine)
> Olso 2.6.11.5 works fine while xfs volumes are in RO mode.

Can you do a binary search to see which 2.6.11.y kernel release broke
this?  For example, try 2.6.11.3.  If that works, then try 2.6.11.4,
otherwise try 2.6.11.2.  And so on.  That will help narrow down the
problem area.

thanks,

greg k-h
