Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSLRRs5>; Wed, 18 Dec 2002 12:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbSLRRs5>; Wed, 18 Dec 2002 12:48:57 -0500
Received: from dsl3-63-249-88-76.cruzio.com ([63.249.88.76]:28328 "EHLO
	athlon.cichlid.com") by vger.kernel.org with ESMTP
	id <S267111AbSLRRs5>; Wed, 18 Dec 2002 12:48:57 -0500
Date: Wed, 18 Dec 2002 09:56:56 -0800
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200212181756.gBIHuud27855@athlon.cichlid.com>
To: linux-kernel@vger.kernel.org
Orig-To: "j.a. magallon" <jamagallon@able.es>
Subject: Re: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Newsgroups: mail.linux.kernel
References: <1_0212161441436926@cichlid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Number of threads	Elapsed time   User Time   System Time
>1                   53:216           53:220    00:000
>2                   29:272           58:180    00:320
>3                   27:162         1:21:450    00:540
>4                   25:094         1:41:080    01:250

>Elapsed is measured by the parent thread, that is not doing anything
>but wait on a pthread_join. User and system times are the sum of
>times for all the children threads, that do real work.

>The jump from 1->2 threads is fine, the one from 2->4 is ridiculous...
>I have my cpus doubled but each one has half the pipelining for floating
>point...see the user cpu time increased due to 'worst' processors and
>cache pollution on each package.

>So, IMHO and for my apps, HyperThreading is just a bad joke.

Why do you care about user time? The elapsed time went down by
4 minutes (2->4 threads), if that's a joke I don't get it :-)

New Intel Ad: "What are you going to do with your 4 minutes today?"

