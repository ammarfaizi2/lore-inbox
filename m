Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281366AbRKEVt5>; Mon, 5 Nov 2001 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281367AbRKEVts>; Mon, 5 Nov 2001 16:49:48 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:65448 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S281362AbRKEVtk> convert rfc822-to-8bit; Mon, 5 Nov 2001 16:49:40 -0500
Date: Mon, 5 Nov 2001 20:04:33 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Josh Fryman <fryman@cc.gatech.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, <pavel@suse.cz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <20011105162753.626cbdb6.fryman@cc.gatech.edu>
Message-ID: <20011105195626.T2092-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Nov 2001, Josh Fryman wrote:

> > Basically, you get two virtual CPU's per die, and each CPU can run two
> > threads at the same time. It slows some stuff down, because it makes for
> > much more cache pressure, but Intel claims up to 30% improvement on some
> > loads that scale well.
> >
> > The 30% is probably a marketing number (ie it might be more like 10% on
> > more normal loads), but you have to give them points for interesting
> > technology <)
>
> Specifically, the 30% comes in two places.  Using Intel proprietary
> benchmarks (unreleased, according to the footnotes) they find that a
> typical IA32 instruction mix uses some 35% of system resources in an
> advanced device like the P4 with NetBurst.  the rest is idle.
>
> by using the SMT model with two virtual systems - each with complete
> register sets and independent APICs, sharing only the backend exec
> units - they claim you get a 30% improvement in wall-clock time.  This
> is supposed to be on their benchmarks *without* recompiling anything.  To
> get "additional" improvement, using code to take advantage of the dual
> virtual CPUs nature of the chip and recompiling should give some
> unquantified gain.

All things being equal, this probably will make a NxMHz P4 be as fast as a
NxMHz PIII. But the new complexity it may require in real life may just
turn the gain into just nil.

What a great improvement, indeed! :-)

  Gérard.

