Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbTBBPeR>; Sun, 2 Feb 2003 10:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTBBPeP>; Sun, 2 Feb 2003 10:34:15 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6924 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265385AbTBBPeL>; Sun, 2 Feb 2003 10:34:11 -0500
Date: Sun, 2 Feb 2003 10:40:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: David C Niemi <lkernel2003@tuxers.net>
cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
In-Reply-To: <Pine.LNX.4.44.0301290904060.7848-100000@harappa.oldtrail.reston.va.us>
Message-ID: <Pine.LNX.3.96.1030202103752.22592D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, David C Niemi wrote:

> 
> On Tue, 28 Jan 2003, David S. Miller wrote:
> >    From: kuznet@ms2.inr.ac.ru
> >    Date: Wed, 29 Jan 2003 02:56:41 +0300 (MSK)
> >
> >    Hey! Interesting thing has just happened, it is the first time when I 
> >    found the bug formulating a senstence while writing e-mail not while 
> >    peering to code. :-)
> > 
> > Congratulations :-)
> 
> Just to confirm, this fix works for me as well.
> 
> ...
> > Indeed, this bug exists in 2.4 as well of course.
> > 
> > This bug is 2.4.3 vintage :-)  It got added as part of initial
> > zerocopy merge in fact.
> 
> Odd, then, that it I was unable to reproduce the SSH hangs under 2.4.18
> even once, despite heavily using it for several days under the same
> circumstances.  Is there any reason 2.4.x would be better able to recover?  
> 2.5.59 with the fix seems to feel a bit less balky than 2.4.18 without the
> fix, so it seemed to me that 2.4.18 had some way of recovering at the cost
> of a several second pause in the session.

The problem which I have been seeing with some regularity is not the hang
you describe (I see that infrequently) but rather a hang after I exit an
ssh connection. I open several dozen windows at a time to a cluster when I
do admin, and when I close almost always at least one doesn't drop without
"~." to help. So far in a hour I haven't seen that.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

