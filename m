Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRHAIu3>; Wed, 1 Aug 2001 04:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRHAIuT>; Wed, 1 Aug 2001 04:50:19 -0400
Received: from d122251.upc-d.chello.nl ([213.46.122.251]:55559 "EHLO
	arnhem.blackstar.nl") by vger.kernel.org with ESMTP
	id <S265249AbRHAIuI>; Wed, 1 Aug 2001 04:50:08 -0400
From: bvermeul@devel.blackstar.nl
Date: Wed, 1 Aug 2001 10:52:45 +0200 (CEST)
To: David Flood <davidflo@nwlink.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac3
In-Reply-To: <Pine.LNX.4.33.0107311656120.1354-100000@ruth.davidflo.nwlink.com>
Message-ID: <Pine.LNX.4.33.0108011051140.23193-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2001, David Flood wrote:

> I also get the same error on a RH 6.2 machine with the same GCC.
> Sounds like time to update the min level of GCC alowed since it
> does compile on my RH 7.1 with 2.96.

Actually, it's binutils that has to be updated. I had to upgrade
my binutils to the RH 7.1 variant on a RH 6.2 box. I've got a source
and binary rpm if someone's interested. Please ask offlist... :)

Bas Vermeulen

>
> On Tue, 31 Jul 2001, Robert Cawley wrote:
>
> >
> > Alan Cox <laughing@shared-source.org> wrote:
> > >2.4.7-ac3
> >
> > make[1]: Entering directory `/usr/src/linux-2.4.7-ac3/arch/i386/kernel'
> > gcc -D__KERNEL__ -I/usr/src/linux-2.4.7-ac3/include -Wall
> > -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> > -fno-strict-aliasing -fno-common -pipe  -march=i686    -c -o traps.o
> > traps.c
> > {standard input}: Assembler messages:
> > {standard input}:430: Error: suffix or operands invalid for `jmp'
> > {standard input}:516: Error: suffix or operands invalid for `jmp'
> > {standard input}:600: Error: suffix or operands invalid for `jmp'
> > {standard input}:684: Error: suffix or operands invalid for `jmp'
> > {standard input}:774: Error: suffix or operands invalid for `jmp'
> > {standard input}:849: Error: suffix or operands invalid for `jmp'
> > {standard input}:931: Error: suffix or operands invalid for `jmp'
> > {standard input}:1002: Error: suffix or operands invalid for `jmp'
> > {standard input}:1073: Error: suffix or operands invalid for `jmp'
> > {standard input}:1144: Error: suffix or operands invalid for `jmp'
> > {standard input}:1215: Error: suffix or operands invalid for `jmp'
> > {standard input}:1295: Error: suffix or operands invalid for `jmp'
> > make[1]: *** [traps.o] Error 1
> >
> > gcc is egcs-2.91.66
> >
> > Robert Cawley
> > ANSTO, PMB 1 Menai 2234, NSW, Australia
> > Phone: +61 2 9717 3049     Fax: +61 2 9717 9525
> > Email: rjc@ansto.gov.au
> >
> >
> >
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"God, root, what is difference?"
	-- Pitr, User Friendly

"God is more forgiving."
	-- Dave Aronson

