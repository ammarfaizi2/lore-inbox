Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTLTO5R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 09:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTLTO5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 09:57:17 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:52203 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263607AbTLTO5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 09:57:14 -0500
Message-ID: <3FE46345.1040102@cyberone.com.au>
Date: Sun, 21 Dec 2003 01:57:09 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: John Hawkes <hawkes@babylon.engr.sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com> <20031220105031.GA17848@elte.hu>
In-Reply-To: <20031220105031.GA17848@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:

>
>So i believe the generic relaxing of sched_clock() synchronization is
>the right thing to do. I like your patch. It adds minimal overhead and
>solves a hard problem - nice work! Andrew, please apply it.
>
>

Its a great looking patch if you must have high res sched_clock. So
I guess I agree with it.

Can we have a scheduler day when Andrew is ready to take patches for
it? I have a few small changes that I'd like to get merged soon too
(not sched domains - that should probably go to the mm tree for a while)

Relevant patches are
sched-ctx-count-preempt.patch
sched-fork-cleanup.patch
sched-migrate-comment.patch
sched-style.patch
sched-migrate-affinity-race.patch



