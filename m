Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281715AbRKZOvb>; Mon, 26 Nov 2001 09:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281714AbRKZOvV>; Mon, 26 Nov 2001 09:51:21 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:18687 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S281710AbRKZOvM>; Mon, 26 Nov 2001 09:51:12 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Martin Persson <martin@cendio.se>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 26 Nov 2001 06:26:20 -0800 (PST)
Subject: Re: Linux 2.4.16-pre1
In-Reply-To: <vwbshp3fdx.fsf@akrulino.lkpg.cendio.se>
Message-ID: <Pine.LNX.4.40.0111260616340.25678-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what you don't seem to realize is that it was the VM problems that made
the 2.4 stabilization problems in the first place.

if the VM system had been as stable as the kernel developers thought it
was in 2.4.0 we would probably have branched the 2.5 series by 2.4.5 or
so, but instead there were attempts to fix the existing Vm until 2.4.9 and
then Linus gave up on it and put in the new VM in 2.4.10 which took a
couple releases to find all the problems in it (pretty good if you
consider how fundamental a change this was)

it wasn't a case of just deciding to use a different VM beecouse it was
newer, it was switched becouse the old one was broken and had proven
unfixable to date.

so all complaints about how the VM change should have waited until 2.5/2.6
ignore the fact that the existing VM system was broken.

more testing is good, but one thing the 2.4 problems have definantly shown
is that there were a LOT of loads/configurations that did not get tested
in the 2.3 series. people waited for a 'stable' kernel to try their loads
on and as such they discovered problems that hadn't been tested in the
development kernels.

if you want to help then figure out how to test the development kernels
more, don't gripe about the stable kernels not being perfect. It doesn't
matter how many -rc kernels there are if most people wait until -final
before doing their testing.

David Lang

 On 26 Nov 2001, Martin Persson wrote:

> Date: 26 Nov 2001 13:06:50 +0100
> From: Martin Persson <martin@cendio.se>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.4.16-pre1
>
> >>>>> On Sat, 24 Nov 2001 22:05:27 -0500, mhaque@haque.net ("Mohammad A. Haque") said:
>
>     Mohammad> On Saturday, November 24, 2001, at 09:41 , Patrick
>     Mohammad> McFarland wrote:
>     >> Okay, so it was 14 that had the file loopback bug, and 12 that
>     >> had the ieee bug.Those bugs shouldnt have been in there in the
>     >> first place! Those are very major potentially show stopping
>     >> bugs. What If I get up one day, and I cant print? Or build
>     >> isos? That sounds minor to you, but thats a big thing if say,
>     >> the linux box is a network print server, or, its the
>     >> workstation for the guy in the company who builds the iso. And,
>     >> no, "use the previous kernel" isnt a good excuse. Because what
>     >> if you get hit with bugs back to back? You'll have to go back
>     >> to some kernel way way back. Like 2.4.2. The Kernel needs
>     >> Quality Assurance.
>
>     Mohammad> Yes, this is a QA problem. But also .. if you're a smart
>     Mohammad> net/system admin, you don't go out installing a just
>     Mohammad> released kernel without letting others bang on it or run
>     Mohammad> it on some test servers. Where I work, I insist the
>     Mohammad> admins wait at least 1-2 weeks before going to the
>     Mohammad> latest release unless there's some huge security fix.
>
> I must say I'm seriously annoyed with the 2.4-tree so far. As far as
> I'm concerned, 2.4 were obviously released too eary (or maybe the
> 2.5-tree should have been opened earlier so we wouldn't had this
> VM-mess in the "stable" release). I'm not so annoyed for my own part
> (I've mainly stayed on the 2.2 and will stay there until 2.4 looks
> sane), but for a friend of mine.
>
> Let me explain: I've had a few discussions with him that he should try
> Linux for his needs, but it's always been "It looks complicated" and
> "I can't play my games" that has stopped him. Now, a few weeks ago
> lokigames released his favourite game and he ordered it, fully decided
> to ditch Windows once and for all, like I did back in the summer if
> -96 and so far I haven't regretted it. But then, 2.0 or 2.2 never felt
> as shaky and unpredictable as 2.4 does right now.
>
> So, off he went, installing RedHat only to find that his soundcard
> didn't work reliable under the pre-built kernel. He decided not to
> give up too fast and compiled his own kernel, several kernels in fact.
> I don't remember how many, but I know that his attempt to try
> 2.4.15preX worked very well, except that his RAID-card refused to
> work, so after much experimenting he found out that
> 2.4.13ac(something) could handle his soundcard and his RAID-card, but
> only one of his CD-ROMs worked. Then the whole kernel finally blew up
> on a VM-bug...
>
> I must say that he really tried. He forsaked much of his spare time to
> learn Linux and he learned a lot rather fast, but when a deadline on
> one of his projects crept too close and he still didn't have a working
> computer, he finally despaired and we lost him back to Windows XP.
>
> It's obvious that stories like this really won't improve the
> reputation of Linux...
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
