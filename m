Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281317AbRKEUMA>; Mon, 5 Nov 2001 15:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281316AbRKEULx>; Mon, 5 Nov 2001 15:11:53 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:16134 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281315AbRKEULn>;
	Mon, 5 Nov 2001 15:11:43 -0500
Date: Mon, 5 Nov 2001 13:11:35 -0800
From: Greg KH <greg@kroah.com>
To: krajput@softhome.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved Symb...in 2.4.12 ehci installation
Message-ID: <20011105131135.B4735@kroah.com>
In-Reply-To: <20011105162810.13878.qmail@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011105162810.13878.qmail@softhome.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 08 Oct 2001 20:04:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 04:28:10PM +0000, krajput@softhome.net wrote:
> 
> I have upgraded my Linux 7.1 (kernel version 2.4.2) to kernel version
> 2.4.12. I want to install the linux ehci driver as well. On applying the
> required changes in the usr/src/linux/drivers/usb/Makefile and
> usr/src/linux/drivers/usb/Config.in files and selecting the EHCI as a
> module in make menuconfig. When i get to the part where i do make
> modules_install after make modules, i get the following error:-
> 
> depmode: *** Unresolved Symbols in
> /lib/modules/2.4.12/kernel/drivers/usb/usbcore.o
> depmode: usb_hub_cleanup
> depmode: usb_hub_init
> 
> I have tried to install the same with and without the kernel version info
> but to no avail. Shall be grateful if anybody could advise! Thanking you in
> advance.

You should try asking this on the linux-usb-devel mailing list.

But anyway, the EHCI patch has not been updated for the later kernels,
sorry.

greg k-h
