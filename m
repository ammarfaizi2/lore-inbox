Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288956AbSBDNSE>; Mon, 4 Feb 2002 08:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSBDNRy>; Mon, 4 Feb 2002 08:17:54 -0500
Received: from beamer.mchh.siemens.de ([194.138.158.163]:16006 "EHLO
	beamer.mchh.siemens.de") by vger.kernel.org with ESMTP
	id <S288956AbSBDNRl>; Mon, 4 Feb 2002 08:17:41 -0500
From: "Thomas Widmann" <thomas.widmann@icn.siemens.de>
To: <linux-kernel@vger.kernel.org>
Subject: trying to vfree() nonexistent vm area
Date: Mon, 4 Feb 2002 14:17:37 +0100
Message-ID: <001901c1ad7e$5107e140$011da8c0@icn01.warp.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I just compiled kernel 2.2.20 with the openwall security patch
on an Compaq DL360 (PIII, 512MB, 800MHZ, Smart Array Controller)
with the following flags:

CFLAGS = -Wall -Wstrict-prototypes -O9 -funroll-loops -ffast-math \
         -malign-double -mcpu=pentiumpro -march=pentiumpro \
         -fomit-frame-pointer -fno-exceptions

When i reboot the box with this kernel i got this error:

checking partitions
dev/ida/ . . . . . . . . .
trying to vfree() nonexistent vm area

after that the machine freezes :-((

Any hints ?

Thanks in advance

Regards
Widmann Thomas

