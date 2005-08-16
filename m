Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVHPE4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVHPE4q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 00:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbVHPE4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 00:56:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:54188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932601AbVHPE4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 00:56:45 -0400
Date: Mon, 15 Aug 2005 17:28:43 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] removes pci_find_device from i6300esb.c
Message-ID: <20050816002843.GA18625@kroah.com>
References: <200508100009.j7A09Qi1003695@wscnet.wsc.cz> <200508160024.j7G0OvmC002258@wscnet.wsc.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508160024.j7G0OvmC002258@wscnet.wsc.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 02:24:57AM +0200, Jiri Slaby wrote:
> This patch changes pci_find_device to pci_get_device (encapsulated in
> for_each_pci_dev) in i6300esb watchdog card with appropriate adding pci_dev_put.
> 
> Generated in 2.6.13-rc5-mm1 kernel version.
> 
> Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> 
> This is repost, the patch was posted yet:
> 8 Aug 2005

I can't take this as the driver is only in the -mm tree, not mainline.
Andrew will have to pick it up (if it's even correct, haven't verified
it or not...)

thanks,

greg k-h
