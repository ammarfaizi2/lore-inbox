Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbSJUCjj>; Sun, 20 Oct 2002 22:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSJUCjj>; Sun, 20 Oct 2002 22:39:39 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59399 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264697AbSJUCji>; Sun, 20 Oct 2002 22:39:38 -0400
Date: Sun, 20 Oct 2002 22:45:29 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Jurriaan <thunder7@xs4all.nl>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
In-Reply-To: <20021020053702.GA3579@middle.of.nowhere>
Message-ID: <Pine.LNX.3.96.1021020224417.1655G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Jurriaan wrote:

> From: Bill Davidsen <davidsen@tmr.com>
> Date: Sat, Oct 19, 2002 at 03:40:22PM -0400
> > I've beaten this dead horse before, but it still irks me that Linux can't
> > power down an SMP system. People claim that it can't be done safely, but
> > maybe somone can reverse engineer NT if we aren't up to the job.
> > 
> I'm trying to find out the same. So far:
> 
> 2.5.43 will power down my smp VP6 board if I replace the BUG() calls in
> arch/i386/kernel/apm.c with warnings. Somehow, the kernel doesn't
> succesfully schedule itself to run on CPU 0. However, for my bios that
> isn't needed.
> 
Are you using the real-mode call? Perhaps I should try NOT doing that, and
see if it solves the problem. That used to be the solution, but things
change.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

