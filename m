Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279535AbRJXLjF>; Wed, 24 Oct 2001 07:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279536AbRJXLi4>; Wed, 24 Oct 2001 07:38:56 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:9864 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S279535AbRJXLio>; Wed, 24 Oct 2001 07:38:44 -0400
From: David Lang <david.lang@digitalinsight.com>
To: DevilKin <DevilKin@gmx.net>
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Date: Tue, 23 Oct 2001 12:09:05 -0700 (PDT)
Subject: Re: More memory == better?
In-Reply-To: <20011023200715.AEF66217593@tartarus.telenet-ops.be>
Message-ID: <Pine.LNX.4.40.0110231208001.13148-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

also remember that without the himem support you only loose 64M or so
(960MB instead of 1024MB IIRC). not the end of the world if you don't run
the himem kernel.

David Lang



On Tue, 23 Oct 2001, DevilKin wrote:

> Date: Tue, 23 Oct 2001 22:04:12 +0200
> From: DevilKin <DevilKin@gmx.net>
> To: davidsen@tmr.com, linux-kernel@vger.kernel.org
> Subject: Re: More memory == better?
>
> On Tuesday 23 October 2001 21:49, bill davidsen wrote:
> > In article <20011023161340.02EAC9BD76@pop3.telenet-ops.be>,
> >
> > DevilKin <DevilKin@gmx.net> wrote:
> > | Currently I've got myself a nice setup (amd 1.4ghz, abit kg7raid etc etc)
> > | with 512mb ram... (DDR). I'm wondering if increasing this to 1gb has
> > | advantages (speedwise or anything), since I can get my hands on it at a
> > | very low price...
> > |
> > | I must say that even with most of my applications loaded/running, the
> > | system never even touches the swap partition.
> > |
> > | So, would it be wise?
> >
> > There are some good reasons to add memory.
> >
> > - disk i/o rates. vmstat will tell you some disk i/o rates, if they are
> > high you *may* get better performance with more memnory for cache.
> >
> > - future applications. As you say it's cheap right now, if you think
> > there's a good chance of larger images, more kernel compiles, whatever,
> > buy now.
> >
> > - memory bandwidth. This is very motherboard dependent, read your specs.
> > Some systems will use two or four way interleave to increase bandwidth
> > to memory or reduce access time. See what your m/b spec tells you.
> >
> > - you have the money and want to spend it on {something}! Go ahead,
> > memory is one of the best investments for any system.
> >
> > Just remember that to use this memory you need a large memory kernel.
>
> Ah, thats with HIGHMEM support? I've read a lot of awful things about it
> here... how stable (aka usable) is it?
>
> DK
> --
> devilkin@gmx.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
