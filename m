Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276042AbSIVCqp>; Sat, 21 Sep 2002 22:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276045AbSIVCqp>; Sat, 21 Sep 2002 22:46:45 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:21377 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S276042AbSIVCqo>; Sat, 21 Sep 2002 22:46:44 -0400
Date: Sat, 21 Sep 2002 19:51:36 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020922025136.GA3346@gnuppy.monkey.org>
References: <20020920234509.GA2810@gnuppy.monkey.org> <Pine.LNX.4.44.0209210649280.2441-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209210649280.2441-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 06:58:15AM +0200, Ingo Molnar wrote:
> as i've mentioned in the previous mail, 2.5.35+ kernels have a very fast
> SIGSTOP/SIGCONT implementation, which change was done as part of this
> project - a few orders faster than throwing/catching SIGUSR1 to every
> single thread for example.

That's good, but having an explict API for suspending threads is very useful,
since it can greatly simplify the already complicated signal handling in
highly threaded systems. It's something that your group should seriously
consider, since I expect some explicit thread suspension call to be implemented
in Posix threading standard, via their committee. Mainly, because of the
advent of heavily threaded language runtimes as standard programming staple.

It's a good thing to have regardless.

> so right now we first need to get some results back about how big the GC
> problem is with the new SIGSTOP/SIGCONT implementation. If it's still not
> fast enough then we still have a number of options.

I'm running out of things to say. ;)

bill

