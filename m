Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263758AbTKKWPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTKKWPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:15:13 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:8832 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S263639AbTKKWPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:15:08 -0500
Message-ID: <002701c3a8a1$b1ce6380$54dc10c3@amos>
From: "Kaj-Michael Lang" <milang@tal.org>
To: <linux-kernel@vger.kernel.org>
Cc: <sparclinux@vger.kernel.org>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos>
Subject: Re: Linux 2.4.23-rc1
Date: Wed, 12 Nov 2003 00:18:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi,
> >
> > Here goes -rc1.
> >
> > It contains network driver fixes (b44, tg3, 8139cp), several x86-64
> > bugfixes, amongst others.
>

And on sparc64 I get:
...
sparc64-linux-gcc -D__KERNEL__ -I/work/collection/talinux/kernel/kernel24/tm
p/sparc64/linux-2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -m
cpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno
-sign-compare -Wa,--undeclared-regs -DMODULE  -nostdinc -iwithprefix
include -DKBUILD_BASENAME=ir_usb  -c -o ir-usb.o ir-usb.c
ir-usb.c: In function `ir_set_termios':
ir-usb.c:571: `B4000000' undeclared (first use in this function)
ir-usb.c:571: (Each undeclared identifier is reported only once
ir-usb.c:571: for each function it appears in.)
make[6]: *** [ir-usb.o] Error 1
make[5]: *** [_modsubdir_serial] Error 2
make[4]: *** [_modsubdir_usb] Error 2
make[3]: *** [_mod_drivers] Error 2
..

-- 
Kaj-Michael Lang , milang@tal.org

