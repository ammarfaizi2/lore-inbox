Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268909AbRG0RoL>; Fri, 27 Jul 2001 13:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268912AbRG0Rn7>; Fri, 27 Jul 2001 13:43:59 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:5871 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S268909AbRG0Rn4>; Fri, 27 Jul 2001 13:43:56 -0400
Date: Fri, 27 Jul 2001 20:43:50 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kip Macy <kmacy@netapp.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010727204350.L1419@niksula.cs.hut.fi>
In-Reply-To: <20010727202950.I1503@niksula.cs.hut.fi> <E15QBbE-00068M-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15QBbE-00068M-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jul 27, 2001 at 06:40:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 06:40:32PM +0100, you [Alan Cox] claimed:
> > After fresh boot to the default RH71 kernel (2.4.2-2 or whatever it is) on
> > console (no X running):
> > 
> > > diff -Naur /usr/src/linux.rh-default /usr/src/linux-2.4.4 > diff
> > zsh: killed diff
> > 
> > > dmesg | tail
> > kernel: out of memory, killed process n (xfs)
> > kernel: out of memory, killed process n (diff)
> > 
> > Phew.
> 
> No argument on that one. I'm still seeing it in vanilla 2.4.6 as well but
> 2.4.7 is looking a lot better. 

I wasn't able to easily reproduce that on 2.4.4ac5 (that I upgraded into
almost immediately). It may be that the OOM rambo wasn't fully sane on that
one either, but at least it seemed to handle the silly "someone filled the
cache - gee, we must be oom" case rather better...


-- v --

v@iki.fi
