Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263442AbRFFBjw>; Tue, 5 Jun 2001 21:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263445AbRFFBjm>; Tue, 5 Jun 2001 21:39:42 -0400
Received: from be02.imake.com ([151.200.87.11]:14865 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S263442AbRFFBje>;
	Tue, 5 Jun 2001 21:39:34 -0400
Message-ID: <3B1D8A82.63FA138C@247media.com>
Date: Tue, 05 Jun 2001 21:42:26 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I also need some 2.4 features and can't really goto 2.2.
I would have to agree that the VM is too broken for production...looking
forward to the work that (hopefully) will be in 2.4.6 to resolve these issues.


"Jeffrey W. Baker" wrote:

> On Tue, 5 Jun 2001, Derek Glidden wrote:
>
> >
> > After reading the messages to this list for the last couple of weeks and
> > playing around on my machine, I'm convinced that the VM system in 2.4 is
> > still severely broken.
> >
> > This isn't trying to test extreme low-memory pressure, just how the
> > system handles recovering from going somewhat into swap, which is a real
> > day-to-day problem for me, because I often run a couple of apps that
> > most of the time live in RAM, but during heavy computation runs, can go
> > a couple hundred megs into swap for a few minutes at a time.  Whenever
> > that happens, my machine always starts acting up afterwards, so I
> > started investigating and found some really strange stuff going on.
>
> I reboot each of my machines every week, to take them offline for
> intrusion detection.  I use 2.4 because I need advanced features of
> iptables that ipchains lacks.  Because the 2.4 VM is so broken, and
> because my machines are frequently deeply swapped, they can sometimes take
> over 30 minutes to shutdown.  They hang of course when the shutdown rc
> script turns off the swap.  The first few times this happened I assumed
> they were dead.
>
> So, unlike what certain people like to repeatedly claim, the 2.4 VM
> problems are causing havoc in the real world.
>
> -jwb
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com

Programming today is a race between software
engineers striving to build bigger and better
idiot-proof programs, and the Universe trying to
produce bigger and better idiots. So far, the
Universe is winning. - Rich Cook
---------------------------------------------------


