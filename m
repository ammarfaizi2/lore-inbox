Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262269AbSJARRD>; Tue, 1 Oct 2002 13:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJARP2>; Tue, 1 Oct 2002 13:15:28 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:27804 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262262AbSJARO7>;
	Tue, 1 Oct 2002 13:14:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: qsbench, interesting results
Date: Tue, 1 Oct 2002 19:20:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>,
       Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0210011407480.653-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.44L.0210011407480.653-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wQhL-0005vQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 19:13, Rik van Riel wrote:
> With one process that needs 150% of RAM as its working set,
> there simply is no way to win.

True, the object is merely to suck as little as possible.  Note that
2.4.xx trounces 2.5.xx rather soundly on the test in question.
 
> > It should run the process as efficiently as possible, given that there
> > isn't any competition.
> 
> If there is no competition I agree.  However, if the system has
> something else running at the same time as qsbench I think the
> system should make an effort to have _only_ qsbench thrashing
> and not every other process in the system as well.

Did I miss something?  I thought the test was just a single instance
of qsbench.

> > Try loading a high res photo in gimp and running any kind of interesting
> > script-fu on it.  If it doesn't thrash, boot with half the memory and
> > repeat.
> 
> But, should just the gimp thrash, or should every process on the
> machine thrash ?

Gimp should thrash exactly as much as it needs to, to get its job
done.  No competition, remember?  I realize you're getting ready to
do a sales job for process load control, but you needn't bother, I'm
already sold.  We're not talking about that.

-- 
Daniel
