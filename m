Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270254AbRHHBGh>; Tue, 7 Aug 2001 21:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270255AbRHHBG1>; Tue, 7 Aug 2001 21:06:27 -0400
Received: from Expansa.sns.it ([192.167.206.189]:62727 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S270254AbRHHBGV>;
	Tue, 7 Aug 2001 21:06:21 -0400
Date: Wed, 8 Aug 2001 03:06:27 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x VM problems thread
In-Reply-To: <Pine.LNX.4.33.0108080246460.17520-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33.0108080304270.17706-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Aug 2001, Luigi Genoni wrote:

>
>
> On Tue, 7 Aug 2001, Mike Fedyk wrote:
>
> > On Wed, Aug 08, 2001 at 02:24:37AM +0200, Luigi Genoni wrote:
> > > This kind of code would kill any Unix system, i think, not just linux 2.4
> > > boxes.
> > >
> >
> > I tried it on 2.2.19-ppc and could kill it with ^C at the prompt, or from
> > root if I was already logged in.  Trying to iniate connections to ssh didn't
> > produce any results after about 30 seconds.
> with linux 2.2 if you run this program and then try to run another process
> you will get a "cannot fork" message.
> no cresh if you can make a ^C or a killall, (you should not be able to run
> a ps). This is the same behaviour of Solaris. With Linux 2.4 you will
> start to fill your swap. kswapd will really stress your system. then you
> should not be able to run any process. If X11 is running, it will be
> freezed.
excuse me, i was starting to write something about X11, then i changed my
mind.
Just read "It will be freezed"
> Same thing if you run AIX and Irix. Note that AIX and Irix are
> quite different on any point of view if you go to process management :).
>
> mmm, HP-UX 10.20 should get frozen too, while HP-UX 11 should act like
> Linux 2.2 (not sure about this, I should check). I do not know about
> FreeBSD.
>
> What changes is the way the system acts when it has to execute a code like
> for (;;)
> 	fork();
>
> That is not related to vm. It is just how fork() is managed.
>
> Note also that libc matters.
>
> >
> > Once it was killed the system was fine.
> >
> > Haven't tried 2.4 yet...
> >
>
> you will see a different behaviour.
>
> bests
> Luigi
>
>
Luigi

