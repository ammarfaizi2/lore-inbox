Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290200AbSAWXVB>; Wed, 23 Jan 2002 18:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290192AbSAWXUw>; Wed, 23 Jan 2002 18:20:52 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:12943 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S290200AbSAWXUf>; Wed, 23 Jan 2002 18:20:35 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: timothy.covell@ashavan.org
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 00:20:28 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0201222310260.13313-100000@infcip10.uni-trier.de> <200201232018.g0NKI9Q06525@dydimus.dreamhost.com> <200201232248.g0NMmqL01292@home.ashavan.org.>
In-Reply-To: <200201232248.g0NMmqL01292@home.ashavan.org.>
Cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020123232045Z290200-13997+8995@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 23:50, you wrote:
> On Wednesday 23 January 2002 14:18, you wrote:
> > On Thursday, 24. January 2002 06:14, Timothy Covell wrote:
> > > I'm confused by all of the posts and websites that
> > > I've read.   In particular, some of the wattage and
> > > temperature claims seem outrageous.   So, here's
> > > what I've been able to discover
> > >
> > > 1. According to AMD specs, the model 3 Duron's don't
> > > use more that 40 Watts maximum.
> > >
> > > 2. With my Duron 800 on a KT133A chipset
> > > running folding@home and seti@home
> > > continuously, LM sensors reports:
> > >
> > > SYS Temp: +45.2°C
> >
> > What should this number mean?
> > Shouldn't this be the CPU temperature?
>
> This corresponds to what my BIOS says is the CPU temp.
>
> > > CPU Temp: +35.1°C
> >
> > Mobo?
>
> This corresponds to what my BIOS says is the system temp.
>
> > > SBr Temp: +25.8°C
> >
> > Case?
>
> That's my guess as well.

OK, I see.

The BIOS numbers are all mostly wrong. When you are in the BIOS config (the 
Del or ESC key thing)...;-)  The CPU is running without any IDLE cycles at 
all.

> > I think this is much to high. Read my other post.
>
> Too high for a duron 800 running seti@home type loads nonstop?

Yes, sorry. I overlooked that.

> I think that this is the expected temperature.

What I expect is:

+45°C CPU
The sensor under the CPU 'cause only the Morgan and Athlon XP/MP have the new 
integrated sensor but only "latest" mobos support it. Not your KT133A based 
one.

+35°C mobo (but I haven't anyone with sensor seen so far)
Could be the CPU -10°C what's sometimes the case with some mobo manufactures.

+25°C System (the case temperature)
With your system load.

An idle system should look like this:

CPU		23-25°C	(with IDLE and BUS GRANT)
system (case)	20-23°C	(room temperature)

At any time (full load) the case temperature shouldn't go over 40°C with all 
stuff running (gfx, disks, lan, etc.). Recommendations from AMD and Intel. 

> I've come to the conclusion that the lm_sensors stuff is crap,

No, they have the frame work in place but need the usefull bits.
That's we are hunting for...

> but not totally because of the authors.  It looks like the manufacturers
> like VIA are not very helpful to the project.....

Very true!

Regards,
	Dieter
-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
