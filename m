Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281761AbRKQPFZ>; Sat, 17 Nov 2001 10:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281762AbRKQPFP>; Sat, 17 Nov 2001 10:05:15 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:55494 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S281761AbRKQPFE>; Sat, 17 Nov 2001 10:05:04 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: safemode <safemode@speakeasy.net>
To: Alvaro Lopes <alvieboy@alvie.com>, war <war@starband.net>
Subject: Re: Swap Usage with Kernel 2.4.14
Date: Sat, 17 Nov 2001 10:05:02 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BF5B275.215D6D44@starband.net> <1005995937.694.0.camel@dwarf>
In-Reply-To: <1005995937.694.0.camel@dwarf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011117150505Z281761-17408+15446@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 November 2001 06:18, Alvaro Lopes wrote:
> On Sáb, 2001-11-17 at 00:42, war wrote:
> > Regular usage on my box, launching netscape, opera, pan, xchat, gaim;
> > the kernel eventually digs into swap.
> >
> > However, the swap is never released?
> >
> > Mem:   900596K av,  185896K used,  714700K free,       0K shrd,    4172K
> > buff
> > Swap: 2048276K av,   63728K used, 1984548K free                   91176K
> > cached
> >
> > Are there any settings I should have set or be aware of?
> >
> > I current use 4GB support, 1GB of ram, 2GB of swap.
> >
> > Having 1GB, I thought I had enough memory for basic operations without
> > the disk swapping like mad.
>
> AFAIK with 2.4.14 processes can be in memory and swap at the same time.
>

look at swap cached in /proc/meminfo       that will tell you what is 
mirrored. 
Also, your box may not be actually doing much swapping if any at all.  vmstat 
will tell if you're actually doing any swapping at a given time.  
Allocation may carry over to swap, but it doesn't effect performance in any 
way in doing so.  That's why looking at anything but vmstat really wont tell 
you much about what's actually being used in swap. 
