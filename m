Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSGDCSA>; Wed, 3 Jul 2002 22:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317318AbSGDCR7>; Wed, 3 Jul 2002 22:17:59 -0400
Received: from cambot.suite224.net ([209.176.64.2]:40465 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S317316AbSGDCR6>;
	Wed, 3 Jul 2002 22:17:58 -0400
Message-ID: <000b01c22301$e9d0a620$08f583d0@pcs686>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <linux-kernel@vger.kernel.org>
Subject: make dep problem in 2.5.24
Date: Wed, 3 Jul 2002 22:24:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fellow Kernel Hackers,

I am in the middle of a semi-major restucturing of the IA-32( aka i386 )
kernel code and have run into a puzzling problem. When I do a "make dep", it
works until it is time to enter the arch/ia32 directory.

The only changes that I have made at present are directory renames of
arch/i386 and include/asm-i386 to arch/ia32 and include/asm-ia32
modifications to the top-level Makefile and arch/ia32/Makefile to reflect
the arch changes.

I do know of 2 ways to work around it, but was wondering if anyone could
tell me why "make dep" and ONLY "make dep" fails without them.

Matthew D. Pitts

