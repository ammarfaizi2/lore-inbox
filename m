Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129831AbQKRRsA>; Sat, 18 Nov 2000 12:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbQKRRrv>; Sat, 18 Nov 2000 12:47:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129831AbQKRRrf>; Sat, 18 Nov 2000 12:47:35 -0500
Subject: Re: Freeze on FPU exception with Athlon
To: sorisor@Hell.WH8.TU-Dresden.De (Udo A. Steinberg)
Date: Sat, 18 Nov 2000 17:17:44 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3A16346B.CF99DF5F@Hell.WH8.TU-Dresden.De> from "Udo A. Steinberg" at Nov 18, 2000 08:48:59 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xBcX-0001sY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus Torvalds wrote:
> > 
> > I sure as hell hope this isn't an Athlon issue.  Can other people try
> > the test-program and see if we have a pattern (ie "it happens only on
> > Athlons", or "Linus is on drugs and it happens for everybody else").
> 
> I've tried both variants (fesetenv and inline-asm) with glibc-2.1.3,
> 2.4.0-test11pre7 and an AMD Thunderbird. Neither does freeze, but
> both yield:
> 
> Floating point exception (core dumped)

Compiler specific ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
