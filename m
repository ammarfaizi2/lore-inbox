Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbQKPXis>; Thu, 16 Nov 2000 18:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbQKPXih>; Thu, 16 Nov 2000 18:38:37 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36682 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130692AbQKPXiZ>; Thu, 16 Nov 2000 18:38:25 -0500
Subject: Re: Which compiler to use?
To: peterd@pnd-pc.demon.co.uk (Peter Denison)
Date: Thu, 16 Nov 2000 23:09:11 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0011162255460.1527-100000@pnd-pc.demon.co.uk> from "Peter Denison" at Nov 16, 2000 11:02:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wY9Z-0008WR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please note that 2.91.66 WILL NOT correctly build any bit of 2.4 (or
> probably 2.2) on i386 that uses the kernel version of strstr, because of a
> register allocation bug. This currently affects the DEPCA driver, but very
> few other things.
> 
> 2.95.2 is OK in this instance and elsewhere for me (YMMV).

2.95.2 miscompiles strstr in some cases too. Current 2.2 however has strstr
no longer inlined. I got bored of playing guess the compiler bug

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
