Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132381AbQLNVDP>; Thu, 14 Dec 2000 16:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132762AbQLNVDF>; Thu, 14 Dec 2000 16:03:05 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16388 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132381AbQLNVC6>; Thu, 14 Dec 2000 16:02:58 -0500
Subject: Re: x86 cpu_data
To: moz@compsoc.man.ac.uk (John Levon)
Date: Thu, 14 Dec 2000 17:57:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012141409280.22487-100000@mrworry.compsoc.man.ac.uk> from "John Levon" at Dec 14, 2000 02:10:57 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146cdg-0000Jm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, I need to check for *only* Intel P6 processors, so no Classic Pentium,
> and no Pentium 4. setup.c is a bit obscure; is this check correct :

Long answer - you cannot reliably check...

Shorter answer

	x86_vendor == INTEL
	x86 = 6

is Pentium Pro-> PentiumIII

The Pentium IV reports x86 = 15. My opinion on that isnt printable ;)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
