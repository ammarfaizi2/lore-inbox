Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284243AbRLFUcz>; Thu, 6 Dec 2001 15:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284206AbRLFUcm>; Thu, 6 Dec 2001 15:32:42 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:53509 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284218AbRLFUbs>; Thu, 6 Dec 2001 15:31:48 -0500
Date: Wed, 5 Dec 2001 23:45:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: "M. Edward Borasky" <znmeb@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Over 4-way systems considered harmful :-)
Message-ID: <20011205234501.B5284@elf.ucw.cz>
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBCEOJECAA.znmeb@aracnet.com> <2436533899.1007458881@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2436533899.1007458881@mbligh.des.sequent.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm going to weigh in here in favor of limiting effort on SMP development by
> > the core Linux team to systems with 4 processors and under. And not just
> > because I'd like to see those developers freed up to work on my M-Audio
> > Delta 66 :-). The economics of massively parallel MIMD machines just aren't
> > there. Sure, the military guys would *love* to have a petaflop engine, but
> > they're gonna build 'em anyway and quite probably not bother to contribute
> > their kernel source on this mailing list. *Commercial* applications for
> > supercomputers of this level are few and far between. I'm happy with my
> > GFlop-level UP Athlon Thunderbird. And if Moore's Law (or the AMD equivalent
> > :-) still holds, in 12 months I'll have something twice as fast (I've had it
> > for six months already :-).
> 
> Two things.
> 
> 1) If a company (say, IBM) pays people to work on 8 / 16 way scalability
> because that's what they want out of Linux, then stopping development
> on that isn't going to get effort redirected to fixing your soundcard (yes,
> I realise you were being flippant, but the point's the same), the headcount
> is just going to disappear. AKA your choice isn't "patches for 8 way
> scalablilty, or patches for subsystem X that you're more interested in",
> your choice is "patches for 8-way scalabity, or no patches". Provided that
> those patches don't break anything else, you still win overall by getting them.
> 
> 2) Working on scalability for 8 / 16 way machines will show up races,
> performance problems et al that exist on 2 / 4 way machines but don't
> show up as often, or as obviously. I have a 16 way box that shows up
> races in the Linux kernel that might take you years to find on a 2 way.
> 
> What I'm trying to say is that you still win. Not as much as maybe you'd
> like, but, hey, it's work you're getting for free, so don't complain too 
> much about it. The maintainers are very good at beating the message
> into us that we can't make small systems any worse performing whilst
> making the big systems better.

Making it perform better, while not hurting up, and *not making code
messier* is good thing. Messiness of code might be as importnat as
performance, or even more important.
								Pavel
-- 
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
