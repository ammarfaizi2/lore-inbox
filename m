Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293390AbSBYMeK>; Mon, 25 Feb 2002 07:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293382AbSBYMeA>; Mon, 25 Feb 2002 07:34:00 -0500
Received: from starbug.ugh.net.au ([203.31.238.37]:14 "EHLO starbug.ugh.net.au")
	by vger.kernel.org with ESMTP id <S293377AbSBYMdq>;
	Mon, 25 Feb 2002 07:33:46 -0500
Date: Mon, 25 Feb 2002 23:33:41 +1100 (EST)
From: David Burrows <snadge@ugh.net.au>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dodgey Linus BogoMIPS code ;) (solved!)
In-Reply-To: <3C7A073D.90A33D03@aitel.hist.no>
Message-ID: <20020225232717.N46728-100000@starbug.ugh.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks all who responded!  It turned out I had a faulty power supply.  It
was causing peculiar failures and then finally a total failure (black
screen).  I have since changed to a new case and everything is fine.

The moral to the story is that computer hardware is not invulnerable.  Try
not to point the finger too soon at software even if other software
"seems" to work properly.

Happy hacking, =)

David.

On Mon, 25 Feb 2002, Helge Hafting wrote:
> David Burrows wrote:
> >
> > On Thu, 21 Feb 2002, Mike Fedyk wrote:
> > > I didn't see one thing mentioning Linus in there... ;)  I could sue if you
> > > were selling something. ;)
> >
> > Kind of.  Except Linus wrote the particular section of code in question.
> > =)
> >
> > > Anyway, jiffies are same as HZ and on i386 100 jiffies/sec, and one timer
> > > interrupt per jiffie.
> >
> > Or perhaps not in the case of my hardware functioning properly one day,
> > and never to boot linux (but fine with everything else) again..
> >
> > I need a sure fire way of testing whether the timer interrupt works,
>
> I once used a printk in the keyboard irq handler to check a
> nonstandard keyboard.  You may put a printk() in the timer interrupt
> handler.
> That should show that the irq handler works.  Of course you don't want
> to
> run such a log-filler for long... :-)
>
> Maybe you can get the machine to boot by skipping the bogomips
> calculation completely - by hardcoding the value your machine used to
> come up with?
> Not for production use - just to get a debugging kernel going.
>
> Helge Hafting
>

