Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWAID6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWAID6M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 22:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWAID6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 22:58:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:26033 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751234AbWAID6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 22:58:12 -0500
Date: Sun, 8 Jan 2006 19:57:17 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: Thinkpad docking station: pci hotplug questions
Message-ID: <20060109035716.GB2824@kroah.com>
References: <20060108191159.GA1880@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108191159.GA1880@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 08:11:59PM +0100, Pavel Machek wrote:
> Hi!
> 
> I'm trying to get PCI hotplug to work on thinkpad x32 -- it is
> apparently neccessary for proper docking station support. What needs
> to be done to get it running?
> 
> I noticed some strangenesses:
> 
> pcihpfs is mentioned in Kconfig, but I can't find it anywhere in
> kernel

Yeah, that's 2.4 stuff, you don't need that anymore, everything shows up
in sysfs now.

> CONFIG_HOTPLUG_PCI_PCIE exists in Makefile but not in Kconfig.

Did you look in drivers/pci/pcie/Kconfig?

> And here are some coding style fixes:

Thanks, I'll queue these up.

greg k-h
