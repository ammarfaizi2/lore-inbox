Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282772AbRK0Dkw>; Mon, 26 Nov 2001 22:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282773AbRK0Dkm>; Mon, 26 Nov 2001 22:40:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:33033 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282772AbRK0Dkf>;
	Mon, 26 Nov 2001 22:40:35 -0500
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
From: Robert Love <rml@tech9.net>
To: Ryan Cumming <bodnar42@phalynx.dhs.org>, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16744i-0004zQ-00@localhost>
In-Reply-To: <Pine.LNX.4.33.0111220951240.2446-300000@localhost.localdomain>
	<1006472754.1336.0.camel@icbm>  <E16744i-0004zQ-00@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 26 Nov 2001 22:39:16 -0500
Message-Id: <1006832357.1385.3.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-22 at 19:20, Ryan Cumming wrote: 

>  Here here, I was just thinking "Well, I like the CPU affinity idea, but I 
> loathe syscall creep... I hope this Robert Love fellow says something about 
> that" as I read your email's header.

I did a procfs-based implementation of a user interface for setting CPU
affinity.  It implements various features like Ingo's with the change
that it is, obviously, a procfs entry and not a set of syscalls. 

It is readable and writable via /proc/<pid>/affinity 

I posted a patch to lkml moments ago, but it is also available at 
	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/cpu-affinity
(please use a mirror).

Comments, suggestions, et cetera welcome -- if possible under the new thread.

	Robert Love

