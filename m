Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVC0SR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVC0SR6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVC0SR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:17:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:667 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261330AbVC0SRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:17:53 -0500
Date: Sun, 27 Mar 2005 10:17:17 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3: class_simple API
Message-ID: <20050327181717.GC14502@kroah.com>
References: <20050327180431.GA4327@nikolas.hn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327180431.GA4327@nikolas.hn.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 01:04:31PM -0500, Nick Orlov wrote:
> 
>  - Whether the changes like the one above are "the right thing to do" ?

Yes.

>  - What's the best way to deal with this particular issue ?

Change the code to not use these functions.  Look at the vmware code for
examples of how to do this.

That was simple :)

thanks,

greg k-h
