Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136184AbRAMK7x>; Sat, 13 Jan 2001 05:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136357AbRAMK7m>; Sat, 13 Jan 2001 05:59:42 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:50336 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S136184AbRAMK7h>; Sat, 13 Jan 2001 05:59:37 -0500
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200101131059.LAA25032@sunrise.pg.gda.pl>
Subject: Re: 2.4.1-pre2/3 and Pentium-III not stable
To: pierre.rousselet@wanadoo.fr (Pierre Rousselet)
Date: Sat, 13 Jan 2001 11:59:28 +0100 (MET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A602DAE.E213A79F@wanadoo.fr> from "Pierre Rousselet" at Jan 13, 2001 11:27:59 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pierre Rousselet wrote:"
> Pentium-III 256Mo
> For testing, I try to compile glibc. The start is good.
> When the process PID reaches a value around 22000
> (variable), all goes wrong. Make gives error messages
> such as :
> 
> make[2]: *** No rule to make target
> `../sysdeps/wordsize-32/bits/wordsi:e.h'
> make[2]: *** No rule to make target
> `/usr/lib/g#c-lib/i686-pc-linux-gnu/2.95.2/include/stddef.h'

As "z" / ":" and "c" / "#" differ only on a single bit
it looks like a bad memory problem.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
