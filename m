Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDPQQz>; Mon, 16 Apr 2001 12:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRDPQQg>; Mon, 16 Apr 2001 12:16:36 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:5401 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S131289AbRDPQQZ>; Mon, 16 Apr 2001 12:16:25 -0400
Date: Mon, 16 Apr 2001 12:16:25 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
In-Reply-To: <20010409201311.D9013@in.ibm.com>
Message-ID: <Pine.LNX.4.10.10104161140190.7022-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The improvement in performance while runnig "chat" benchmark 
> (from http://lbs.sourceforge.net/) is about 30% in average throughput.

isn't this a solution in search of a problem?
does it make sense to redesign parts of the kernel for the sole
purpose of making a completely unrealistic benchmark run faster?

(the chat "benchmark" is a simple pingpong load-generator; it is
not in the same category as, say, specweb, since it does not do *any*
realistic (nonlocal) IO.  the numbers "chat" returns are interesting,
but not indicative of any problem; perhaps even less than lmbench
components.)

