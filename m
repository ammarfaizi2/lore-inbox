Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288334AbSANACQ>; Sun, 13 Jan 2002 19:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSANACH>; Sun, 13 Jan 2002 19:02:07 -0500
Received: from paloma14.e0k.nbg-hannover.de ([62.181.130.14]:42149 "HELO
	paloma14.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288334AbSANABw>; Sun, 13 Jan 2002 19:01:52 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: J Sloan <jjs@pobox.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 01:00:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020113201352Z288089-13997+4417@vger.kernel.org> <3C421946.6020607@pobox.com>
In-Reply-To: <3C421946.6020607@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114000201Z288334-13997+4486@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 14. January 2002 00:33, J Sloan wrote:
> Dieter Nützel wrote:

> >I am, too. But more for 3D visualization/simulation (with audio).
>
> Certainly not conflicting goals!

Yes.

> >>Kernel
> >>compilation time is the farthest thing from my
> >>mind when e.g. playing Q3A!
> >
> >Q3A is _NOT_ changed in any case. Even some smoother system "feeling" with
> > Q3A and UT 436 running in parallel on an UP 1 GHz Athlon II, 640 MB.
>
> That's odd - for me the low latency kernels give
> not only a smoother feel, but also markedly higher
> standing on average at the end of the game.

What did you see?
During timedemo or avg fps?

> Perhaps your setup has something that is
> mitigating the beneficial effects of the low
> latency modifications?
>
> Are you running a non-ext2 filesystem?

Of course. All ReiserFS.
I have normally posted that together with my preempt numbers.
lock-brake has some code for ReiserFS in it. I did the testing for Robert.

> Do you have a video card that grabs the
> bus for long periods?

Don't know.
Any tools available for measuring?
Latest development stuff for a Voodoo5 5500 AGP (XFree86 DRI CVS, 
mesa-4-branch). I am somewhat in the DRI development involved.
Glide3/3DNow!

> And you set /proc/sys/kernel/lowlatency=1...

I think I hadn't forgetten that.

> >Have you seen something on any Win box?
>
> I have seen the games played on windoze and
> have played at lan parties with win32 opponents
> but I do not personally play games on windoze.
> Lack of interest, I guess...

I meant both running together at the same time.
Never seen that on a Windows box...

> On a kernel with both tux and preempt, upon
> access to the tux webserver the kernel oopses
> and tux dies. Not good when I depend on tux.
>
> OTOH the low latency patch plays quite well
> with tux. As said, I have no anti-preempt agenda,
> I just need for whatever solution I use to work,
> and not crash programs and services we use.

Sure. I only want to know your problem.

> >Some latency numbers coming soon.
>
> Great!

With some luck tonight.
It is 1 o'clock local time, here...

-Dieter
