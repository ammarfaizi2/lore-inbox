Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbTABOdr>; Thu, 2 Jan 2003 09:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbTABOdr>; Thu, 2 Jan 2003 09:33:47 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:26028 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S261689AbTABOdq>; Thu, 2 Jan 2003 09:33:46 -0500
Message-ID: <20030102144208.9410.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 02 Jan 2003 22:42:08 +0800
Subject: Re: Linux v2.5.54
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inter -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vm86 -DKBUILD_MODNAME=vm86   -c -o arch/i386/kernel/vm86.o arch/i386/kernel/vm86.c
arch/i386/kernel/vm86.c: In function `save_v86_state':
arch/i386/kernel/vm86.c:119: structure has no member named `saved_fs'
arch/i386/kernel/vm86.c:120: structure has no member named `saved_gs'
arch/i386/kernel/vm86.c: In function `do_sys_vm86':
arch/i386/kernel/vm86.c:288: structure has no member named `saved_fs'
arch/i386/kernel/vm86.c:289: structure has no member named `saved_gs'
make[1]: *** [arch/i386/kernel/vm86.o] Error 1
make: *** [arch/i386/kernel] Error 2

Any hint ?

Ciao,
           Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
