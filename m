Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTB0SQX>; Thu, 27 Feb 2003 13:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTB0SQX>; Thu, 27 Feb 2003 13:16:23 -0500
Received: from [209.195.52.120] ([209.195.52.120]:45225 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id <S265603AbTB0SQV>; Thu, 27 Feb 2003 13:16:21 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Daniel Egger <degger@fhm.edu>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2003 10:25:23 -0800 (PST)
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <1046368220.14387.23.camel@sonja>
Message-ID: <Pine.LNX.4.44.0302271012300.18965-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0302271012302.18965@dlang.diginsite.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003, Daniel Egger wrote:

> Date: Thu, 27 Feb 2003 09:50:21 -0800
> From: Daniel Egger <degger@fhm.edu>
> To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Minutes from Feb 21 LSE Call
>
> Am Mit, 2003-02-26 um 06.30 schrieb Bernd Eckenfels:
>
> > > unfortunantly for them the core CPU speeds became uncoupled from the
> > > memory speeds and skyrocketed up to the point where CISC cores are
> as fast
> > > or faster then the 'high speed' RISC cores.
>
> > Hmm.. are there any RISC Cores which run even closely to CISC Speeds?
>
> Define RISC and CISC: do you mean pure RISC implementations or RISC
> implementations with CISC frontend?

as far as programmers and users are concerned there is no difference
between CISC and RISC with a CISC front-end (transmeta is the most obvious
example of this, but all current CISC chips use this technique)

> Define Speed: Felt speed, clock speed or measurable speed?

for my origional post I was refering to pure clock speeds, remember that
the origional RISC chips came out when CISC chips were just starting to
hit 60MHz and a large part of their claim was that it didn't matter if the
chip got less done per clock becouse they could run at much higher speeds
(a couple hundred MHz). Also the Instructions per Clock for CISC chips was
very high with the RISC chips pushing towards 1 IPC.

the reasoning was that there was no way to implement all the complicated
CISC instruction set decoding and options and achieve anything close to
the clock speeds that the nice streamlined RISC chips could reach.

when the RISC chip cores are just over 1GHz and talking about possibly
hitting 1.8GHz within a year or so the intel chips are pushing 3GHz while
the AMD chips are pushing 2GHz (true speed, I'll avoid commenting on the
mistakes that intel made on the P4 that make these chips competitive with
each other :-)

and the IPC of current CISC implementations is pushing towards 1 as well
(insert disclaimer about benchmarks) so RISC no longer has a huge
advantage there either.

obviously higher clock speeds to not directly equate to higher
performance, but as Linus has pointed out there are a lot of efficiancies
in the CISC command set that mean that if you have two chips running at
the same clockspeed with the same IPC the CISC command set will outperform
the RISC one.

the only serious advantage the RISC chips have today is the fact that they
are 64 bit instead of 32 bit, and x86-64 will erase that limitation.

David Lang

> I'm convinced that for each (sensible) combination of definations above
> there's a clear indication that your question is wrong.
>
> --
> Servus,
>        Daniel
>
