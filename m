Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274248AbRJUVlN>; Sun, 21 Oct 2001 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274062AbRJUVlD>; Sun, 21 Oct 2001 17:41:03 -0400
Received: from shake.vivendi.hu ([213.163.0.180]:20610 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S273349AbRJUVkz>; Sun, 21 Oct 2001 17:40:55 -0400
Date: Sun, 21 Oct 2001 23:41:21 +0200
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: "D. Stimits" <stimits@idcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Message-ID: <20011021234121.B21640@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <E15vO29-0008ED-00@calista.inka.de> <15vPqi-1pZTN2C@fmrl02.sul.t-online.com> <3BD33C2F.9A948EC6@idcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <3BD33C2F.9A948EC6@idcomm.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.12 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 03:20:47PM -0600, D. Stimits wrote:
> Tim Jansen wrote:
> > 
> > On Sunday 21 October 2001 21:13, Bernd Eckenfels wrote:
> > > Well, it is not a question of moving X or Office into Kernel Space. But
> > > current development clearly shows, that some things like Video Card Access
> > > need Kernel Support. IMHO the Amount of GDI related Functions in NT Kernel
> > > are too much, but X11 is not exactly the Windowing System you can consider
> > > well suited for Desktop and Game Use.
> > 
> > Actually some gfx code has already been moved into the kernel, see DRI and
> > the nvidia kernel modules. And AFAIK there aren't any noticably speed
> > differences between nvidia's linux drivers and the Windows drivers, at least
> > not for 3D, so X11 can't be that bad.
> 
> It isn't bad at all. My GeForce I DDR typically exceeds 300 FPS, and

Yes-yes! XFree does not put more extra overhead than Windows ... And even
the first drivers for XFree 4 almost gave the same result as Windows
Turbo GL drivers ... Probably architecture of XFree/DRI/GLX/etc is MUCH
better than Windows! The problem is "ONLY" that there're less GOOD driver
written for Linux/XFree than Windows ... I don't see any major problem
with XFree ... only write GOOD drivers and make vendors release drivers
which are as good as Windows drivers (or better ...)

If someone wants to move more things into kernel space it will cause
LESS driver for Linux since many vendor does not like release open
source drivers (as I said it's because of our non-perfect world :),
and it's much harder to produce binary-only drivers as kernel modules
than let's say XFree drivers. But this is only ONE point. The techniqual
one is also forces me to say that keep as much things in user space as
possible (of course without major hurting in performance ...).

- Gabor
