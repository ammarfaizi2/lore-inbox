Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261445AbREOUXs>; Tue, 15 May 2001 16:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbREOUXj>; Tue, 15 May 2001 16:23:39 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:50695 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261439AbREOUXc>; Tue, 15 May 2001 16:23:32 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200105151910.VAA01031@kufel.dom>
Subject: Re: Kernel 2.4.4 Compilation Error
To: kufel!att.net.mx!sancherhec@green.mif.pg.gda.pl (Hector Sanchez
	Hernandez)
Date: Tue, 15 May 2001 21:10:42 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <3B016488.B709D322@att.net.mx> from "Hector Sanchez Hernandez" at maj 15, 2001 12:16:56 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'd tried to make my 2.4.4 kernel. But after I made the "make bzImage"
> the following error arose:
> 
> gcc -D__KERNEL__ -I/Usr/src/linux/2.2.4/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
> -march=i686 -c -o i387.o i387.c
> {standard input}: Assambler messages:
> {standard input}:30 Error: no such 386 instruction: `ldmxcsr'

You need newer binutils.

Andrzej

