Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQKPS1c>; Thu, 16 Nov 2000 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbQKPS1W>; Thu, 16 Nov 2000 13:27:22 -0500
Received: from 24.68.3.210.on.wave.home.com ([24.68.3.210]:18173 "EHLO
	phlegmish.com") by vger.kernel.org with ESMTP id <S130177AbQKPS1L>;
	Thu, 16 Nov 2000 13:27:11 -0500
From: David Won <phlegm@home.com>
Date: Thu, 16 Nov 2000 12:53:05 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="ISO-8859-1"
To: greg@linuxpower.cx
In-Reply-To: <3A1402FA.3010406@home.com>
In-Reply-To: <3A1402FA.3010406@home.com>
Subject: Re: [Fwd: Re: Newby help. Tons and tons of Oops]
Cc: linux-kernel@vger.kernel.org, 20001113162205.A30602@profile4u.com
MIME-Version: 1.0
Message-Id: <00111612530501.00807@phlegmish.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it, rebooted and still no luck. Is there anything I can check in my 
proc files to see if I have a conflict?

Dave

>
>
> Remove your swap from your /etc/fstab and see if your problem goes away.
>
> On Thu, Nov 16, 2000 at 02:42:44AM -0500, David Won wrote:
> > Delivered-To: greg@linuxpower.cx
> > From: David Won
> > Date: Thu, 16 Nov 2000 02:42:44 -0500
> > X-Mailer: KMail [version 1.1.99]
> > Cc: Gregory Maxwell ,
> > 	linux-kernel@vger.kernel.org
> > To: "Arnaud S . Launay"
> > In-Reply-To: <20001113162205.A30602@profile4u.com>
> > Subject: Re: Newby help. Tons and tons of Oops
> >
> > I just noticed these errors in my log as well. Something is weird with my
> > swapping I think. If I get Oops that say "Unable to handle kernel paging
> > request at virtual address ff7f1014" would that not be swap since it is
> > virtual?
> > The errors that make me think it may be with my swapper are as follows.
> >
> > Nov 12 21:12:51 phlegmish kernel: swap_free: Trying to free nonexistent
> > swap-page
> > Nov 12 21:12:51 phlegmish kernel: swap_free: Trying to free nonexistent
> > swap-page
> > Nov 14 02:57:28 phlegmish rc.sysinit: Enabling swap space:  succeeded
> > Nov 14 03:01:51 phlegmish kernel: swap_free: offset exceeds max
> > Nov 14 03:01:51 phlegmish kernel: swap_free: offset exceeds max
> > Nov 14 03:17:37 phlegmish kernel: swap_free: Trying to free nonexistent
> > swap-page
> > Nov 14 03:17:37 phlegmish kernel: swap_free: Trying to free nonexistent
> > swap-page
> >
> >
> > And so on......
> > I tried deleting my swap partiton and recreating it but that made no
> > difference.  Any ideas or things to try?
> >
> > Thanks for the help so far
> > Dave
> >
> > On Monday 13 November 2000 10:22, Arnaud S . Launay wrote:
> > > Le Mon, Nov 13, 2000 at 07:59:24AM -0500, David Won a écrit:
> > > > I'm running 2.4.0test11pre3. but the kernel shipped with Redhat 7
> > > > doesn't work either. When I was running 2.2.15 and RedHat 6.2 before
> > > > upgrading it worked great. Never had an oops ever.
> > > > I ran a memory checker under dos as well and it didn't find anything.
> > > > Any tips?
> > >
> > > Could you please check:
> > > 1/ if memtest really worked, as I had problems with 2.4 (in fact, it
> > > wasn't launched, I had to downgrade to 2.3 for having a test) (have you
> > > seen a scrolling bar of '#' ?) (anyway, i'm sending 2.3 binary
> > > privatly) 2/ your hardware internal temperature (put your hand into the
> > > box) 3/ if every cable is correctly plugged in
> > >
> > > It looks to me like an hardware failure, not a software one.
> > >
> > > 	Arnaud.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
