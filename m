Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317922AbSGKWXM>; Thu, 11 Jul 2002 18:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317923AbSGKWXL>; Thu, 11 Jul 2002 18:23:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8463 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317922AbSGKWXK>; Thu, 11 Jul 2002 18:23:10 -0400
Date: Thu, 11 Jul 2002 18:31:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Paul Larson <plars@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-rc1 sending SIGALRM to exec'd process
In-Reply-To: <1026250476.32159.11.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0207111831210.21365-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jul 2002, Paul Larson wrote:

> On Tue, 2002-07-09 at 11:33, Paul Larson wrote:
> > 2.4.19-rc1 seems to be having trouble sending a SIGALRM process that
> > have been exec'd on one of my test boxes.  From the Linux Test Project,
> > alarm04 test:
> >
> > sig_rev     1  FAIL  :  alarm() fails to send SIGALRM to execed
> >                                   process
> >
> > Also, the gettimeofday02 test fails when execed from the test driver,
> > but not when you run it alone.  This test also sends a SIGALRM to know
> > when it's done.
> Nevermind, I think this can safely be ignored.  I can reliably reproduce
> it on this one machine, but not on anything else and I suspect that
> there may be a preexisting condition with the machine that is having
> problems.  I borrowed it in a pinch to get the testing done while I was
> rebuilding my regular test box.  My regular test box is rebuilt now, so
> I'll rerun on that one.

Ho hum, OK.

One more thing: Does 2.4.18 fails the test on _that_ box ?

