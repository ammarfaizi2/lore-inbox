Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbULTAdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbULTAdf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbULTAde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:33:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:28881 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261363AbULTAdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:33:25 -0500
Date: Sun, 19 Dec 2004 16:31:46 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: mdharm-usb@one-eyed-alien.net, zaitcev@yahoo.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041220003146.GB11358@kroah.com>
References: <20041220001644.GI21288@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041220001644.GI21288@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 01:16:44AM +0100, Adrian Bunk wrote:
> I've already seen people crippling their usb-storage driver with 
> enabling BLK_DEV_UB - and I doubt the warning in the help text added 
> after 2.6.9 will fix all such problems.
> 
> Is there except for kernel size any good reason for using BLK_DEV_UB 
> instead of USB_STORAGE?

You don't want to use the scsi layer?  You like the stability of it at
times?  :)

> If not, I'd suggest the patch below to let BLK_DEV_UB depend
> on EMBEDDED.

No, it's good for non-embedded boxes too.

thanks,

greg k-h
