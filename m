Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSLKFIA>; Wed, 11 Dec 2002 00:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSLKFIA>; Wed, 11 Dec 2002 00:08:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:23054 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267016AbSLKFH7>;
	Wed, 11 Dec 2002 00:07:59 -0500
Date: Tue, 10 Dec 2002 21:14:26 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems build usb-serial as a module in 2.5.51
Message-ID: <20021211051426.GB13718@kroah.com>
References: <200212102109.18143.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212102109.18143.tomlins@cam.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 09:09:18PM -0500, Ed Tomlinson wrote:
> I get this building 2.5.51
> 
> make -f scripts/Makefile.build obj=drivers/usb/serial
>   gcc -Wp,-MD,drivers/usb/serial/.usb-serial.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=usb_serial -DKBUILD_MODNAME=usbserial -DEXPORT_SYMTAB  -c -o drivers/usb/serial/usb-serial.o drivers/usb/serial/usb-serial.c
> {standard input}: Assembler messages:
> {standard input}:2592: Error: value of -129 too large for field of 1 bytes at 5820

What version of gcc and what is your .config for the CONFIG_USB_SERIAL_*
options?

thanks,

greg k-h
