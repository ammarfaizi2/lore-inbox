Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVB1Ux3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVB1Ux3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 15:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVB1Ux3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 15:53:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:49581 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261613AbVB1Ux1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 15:53:27 -0500
Date: Mon, 28 Feb 2005 12:52:51 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix few remaining u32 vs. pm_message_t issues
Message-ID: <20050228205251.GA22844@kroah.com>
References: <20050228201536.GA12861@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228201536.GA12861@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 09:15:36PM +0100, Pavel Machek wrote:
> Hi!
> 
> -mm is pretty good in u32 vs. pm_message_t area, there are only few
> -places missing. Some of them are in usb (and already on their way
> -through greg), this should fix the rest. Only code change is
> -pci_choose_state in savagefb. Please apply,

If you split out the drivers/base/* and the drivers/pci/* ones I'll add
those to my trees too.

thanks,

greg k-h
