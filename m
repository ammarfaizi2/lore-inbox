Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292678AbSBURu0>; Thu, 21 Feb 2002 12:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292680AbSBURuS>; Thu, 21 Feb 2002 12:50:18 -0500
Received: from boink.boinklabs.com ([162.33.131.250]:48400 "EHLO
	boink.boinklabs.com") by vger.kernel.org with ESMTP
	id <S292678AbSBURuA>; Thu, 21 Feb 2002 12:50:00 -0500
Date: Thu, 21 Feb 2002 12:49:59 -0500
From: Charlie Wilkinson <cwilkins@boinklabs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Hard lock-ups on RH7.2 install - Via Chipset?
Message-ID: <20020221124959.A12456@boink.boinklabs.com>
In-Reply-To: <20020221110156.B9728@boink.boinklabs.com> <Pine.LNX.4.33.0202211106340.16271-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.33.0202211106340.16271-100000@coffee.psychology.mcmaster.ca>; from hahn@physics.mcmaster.ca on Thu, Feb 21, 2002 at 11:07:11AM -0500
X-Home-Sweet-Home: RedHat 6.0 / Linux 2.2.12 on an AMD K6-225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 11:07:11AM -0500, Mark Hahn waxed eloquent:
[...]
> > Hi Mark,
> > Yeah, Alan suggested his latest pre 2.4.18 kernel *might* work.  Tried it,
> > still no joy. :/
> 
> but HOW?

How did I try it, or how no joy?  ;)

On the former, I didn't run any really exhaustive tests, and Alan
didn't suggest using or avoiding certain options.  I built a relatively
conservative kernel and then beat on all four drives with concurrent dd's.
I also did an hdparm -tT.  hdparm killed the box in a matter of a second
or two.  dd took about 30 seconds.  It seems safe to assume that hdparm
is able to create a higher load.

On the latter, the box just freezes up solid.  No magic SysRq, no nothing.
A very frustrating state to try and troubleshoot.  Any suggestions?

-cw-
