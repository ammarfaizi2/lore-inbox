Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283219AbRLDRpH>; Tue, 4 Dec 2001 12:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281153AbRLDRnm>; Tue, 4 Dec 2001 12:43:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:35488 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281645AbRLDRmv>; Tue, 4 Dec 2001 12:42:51 -0500
Date: Tue, 04 Dec 2001 09:41:21 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Over 4-way systems considered harmful :-)
Message-ID: <2436533899.1007458881@mbligh.des.sequent.com>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBCEOJECAA.znmeb@aracnet.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm going to weigh in here in favor of limiting effort on SMP development by
> the core Linux team to systems with 4 processors and under. And not just
> because I'd like to see those developers freed up to work on my M-Audio
> Delta 66 :-). The economics of massively parallel MIMD machines just aren't
> there. Sure, the military guys would *love* to have a petaflop engine, but
> they're gonna build 'em anyway and quite probably not bother to contribute
> their kernel source on this mailing list. *Commercial* applications for
> supercomputers of this level are few and far between. I'm happy with my
> GFlop-level UP Athlon Thunderbird. And if Moore's Law (or the AMD equivalent
> :-) still holds, in 12 months I'll have something twice as fast (I've had it
> for six months already :-).

Two things.

1) If a company (say, IBM) pays people to work on 8 / 16 way scalability
because that's what they want out of Linux, then stopping development
on that isn't going to get effort redirected to fixing your soundcard (yes,
I realise you were being flippant, but the point's the same), the headcount
is just going to disappear. AKA your choice isn't "patches for 8 way
scalablilty, or patches for subsystem X that you're more interested in",
your choice is "patches for 8-way scalabity, or no patches". Provided that
those patches don't break anything else, you still win overall by getting them.

2) Working on scalability for 8 / 16 way machines will show up races,
performance problems et al that exist on 2 / 4 way machines but don't
show up as often, or as obviously. I have a 16 way box that shows up
races in the Linux kernel that might take you years to find on a 2 way.

What I'm trying to say is that you still win. Not as much as maybe you'd
like, but, hey, it's work you're getting for free, so don't complain too 
much about it. The maintainers are very good at beating the message
into us that we can't make small systems any worse performing whilst
making the big systems better.

Martin.

