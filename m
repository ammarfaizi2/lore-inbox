Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280508AbRKJJBn>; Sat, 10 Nov 2001 04:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280594AbRKJJBe>; Sat, 10 Nov 2001 04:01:34 -0500
Received: from Expansa.sns.it ([192.167.206.189]:4109 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S280508AbRKJJB2>;
	Sat, 10 Nov 2001 04:01:28 -0500
Date: Sat, 10 Nov 2001 10:01:25 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Calin A. Culianu" <calin@ajvar.org>
cc: Wilson <defiler@null.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Any lingering Athlon bugs in Kernel 2.4.14?
In-Reply-To: <Pine.LNX.4.30.0111091834030.17281-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.4.33.0111100957510.26087-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Nov 2001, Calin A. Culianu wrote:

> On Thu, 8 Nov 2001, Alan Cox wrote:
>
> > > > Or are we talking about Athlon-optimizations bugs ? Or about Athlon SMP ?
> > >
> > > Bugs in the Athlon optimizations present in the Linux kernel.
> >
> > The only bugs we've seen recently appear to be in Athlon chipsets and/or
> > BIOS  setup. 2.4.14 should sort those by poking around and doing what the
> > BIOS didn't
>
> Alan:
>
> Specifically what chipsets are affected, and/or what things in the BIOS
> can trigger problems?  (I have VIA KT266 chipsets on SpaceWalker AK31
> motherboards... 33 of them to be precise.. and many of the machines seem
> to be somewhat unstable!)
VIA KT133 KT133 for sure, with abit bios 1.3R. but We saw report of other
bios with similar problema.
A work around for the bioses with the 55.7 register not setted to 0 has
been merged in the main kernel starting from 2.4.11.

about symptoms... Hand at boot, filesystem corruption under eavy I/O
load...
Do not worry, those are kind of problems that everyone could hardly
ignore.

Luigi


