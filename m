Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSLKCBd>; Tue, 10 Dec 2002 21:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSLKCBd>; Tue, 10 Dec 2002 21:01:33 -0500
Received: from services.cam.org ([198.73.180.252]:47802 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S266962AbSLKCBc>;
	Tue, 10 Dec 2002 21:01:32 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: problems build usb-serial as a module in 2.5.51
Date: Tue, 10 Dec 2002 21:09:18 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212102109.18143.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this building 2.5.51

make -f scripts/Makefile.build obj=drivers/usb/serial
  gcc -Wp,-MD,drivers/usb/serial/.usb-serial.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=usb_serial -DKBUILD_MODNAME=usbserial -DEXPORT_SYMTAB  -c -o drivers/usb/serial/usb-serial.o drivers/usb/serial/usb-serial.c
{standard input}: Assembler messages:
{standard input}:2592: Error: value of -129 too large for field of 1 bytes at 5820
make[3]: *** [drivers/usb/serial/usb-serial.o] Error 1
make[2]: *** [drivers/usb/serial] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2
You have new mail.

TIA
Ed Tomlinson

