Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130159AbQKRITd>; Sat, 18 Nov 2000 03:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130992AbQKRITY>; Sat, 18 Nov 2000 03:19:24 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:41484 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S130159AbQKRITG>; Sat, 18 Nov 2000 03:19:06 -0500
Message-ID: <3A16346B.CF99DF5F@Hell.WH8.TU-Dresden.De>
Date: Sat, 18 Nov 2000 08:48:59 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <20001118014019.18006.qmail@web3404.mail.yahoo.com> <8v4vep$15d$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> I sure as hell hope this isn't an Athlon issue.  Can other people try
> the test-program and see if we have a pattern (ie "it happens only on
> Athlons", or "Linus is on drugs and it happens for everybody else").

I've tried both variants (fesetenv and inline-asm) with glibc-2.1.3,
2.4.0-test11pre7 and an AMD Thunderbird. Neither does freeze, but
both yield:

Floating point exception (core dumped)

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
