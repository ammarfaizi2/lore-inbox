Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbSLAPOW>; Sun, 1 Dec 2002 10:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSLAPOW>; Sun, 1 Dec 2002 10:14:22 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:63149 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S261861AbSLAPOV>; Sun, 1 Dec 2002 10:14:21 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel build of 2.5.50 fails on Alpha
Date: Sun, 1 Dec 2002 16:21:45 +0100
Message-ID: <000701c2994d$5ccee670$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel build of 2.5.50 fails on Alpha:



gcc -Wp,-MD,init/.do_mounts.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-protot
ypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointe
r -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5 -Wa,-mev6 -nostdinc -iwithprefix
include    -DKBUILD_BASENAME=do_mounts -DKBUILD_MODNAME=do_mounts   -c -o
init/do_mounts.o init/do_mounts.c
In file included from include/linux/raid/md.h:27,
                 from init/do_mounts.c:25:
include/linux/module.h:135: field `arch' has incomplete type
make[1]: *** [init/do_mounts.o] Error 1
make: *** [init] Error 2


