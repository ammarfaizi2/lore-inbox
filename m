Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRKVRn5>; Thu, 22 Nov 2001 12:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280132AbRKVRns>; Thu, 22 Nov 2001 12:43:48 -0500
Received: from [195.66.192.167] ([195.66.192.167]:20496 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280190AbRKVRng>; Thu, 22 Nov 2001 12:43:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
Subject: Re: OOM killer in 2.4.15pre1 still not 100% ok
Date: Thu, 22 Nov 2001 19:42:40 -0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01112217224700.01298@manta> <E166wVS-0004Vk-00@localhost>
In-Reply-To: <E166wVS-0004Vk-00@localhost>
MIME-Version: 1.0
Message-Id: <01112219424001.01298@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 November 2001 14:15, Ryan Cumming wrote:
> On November 22, 2001 11:22, vda wrote:
> > Today I saw OOM killer in action for the very fist time.
> > Just want to inform that it still not 100% ok (IMHO):
> >
> > I reconfigured my text box for NFS root fs operation
> > and turned off swap. The box has 128M RAM.
>
> ...
>
> > 5:01pm  up  1:08,  3 users,  load average: 0.18, 0.10, 0.06
> > 61 processes: 58 sleeping, 2 running, 1 zombie, 0 stopped
> > CPU states:  1.9% user, 15.6% system,  0.0% nice, 82.3% idle
> > Mem:  126272K av, 123428K used,   2844K free,      0K shrd,     16K buff
> >Swap:      0K av,      0K used,      0K free                 47748K cached
>
> Er, with almost 3megs of free memory and -47megs- of cache, the problem
> isn't with the OOM killer's selection, but the fact it was triggered with
> nearly half the RAM still usable. Do you actually know the OOM killer was
> triggered? Or did top just mysteriously exit?

I have no swap at all.
There was a message "Out of Memory: killing process top" or something such
on screen.
--
vda
