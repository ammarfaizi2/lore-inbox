Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSFUFpF>; Fri, 21 Jun 2002 01:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSFUFpE>; Fri, 21 Jun 2002 01:45:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11630 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S316258AbSFUFpD>; Fri, 21 Jun 2002 01:45:03 -0400
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
	<m1d6umtxe8.fsf@frodo.biederman.org>
	<20020620103003.C6243@host110.fsmlabs.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jun 2002 23:34:54 -0600
In-Reply-To: <20020620103003.C6243@host110.fsmlabs.com>
Message-ID: <m1vg8dry81.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cort Dougan <cort@fsmlabs.com> writes:

> "Beating the SMP horse to death" does make sense for 2 processor SMP
> machines.  When 64 processor machines become commodity (Linux is a
> commodity hardware OS) something will have to be done.  When research
> groups put Linux on 1k processors - it's an experiment.  I don't think they
> have much right to complain that Linux doesn't scale up to that level -
> it's not designed to.
> 
> That being said, large clusters are an interesting research area but it is
> _not_ a failing of Linux that it doesn't scale to them.

Linux in a classic beowulf configuration scales just fine.   To be clear
I am talking a batch scheduling system, where the jobs which run for
hours at a time and on many nodes, possibly the entire cluster at a
time. Are scheduled on some number of commodity systems, with a good
network interconnect.

The concern now is not does it work, or does it work well.  But can
it be made more convenient to use.  

Eric

