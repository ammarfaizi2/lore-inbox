Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264647AbSKSORY>; Tue, 19 Nov 2002 09:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSKSORY>; Tue, 19 Nov 2002 09:17:24 -0500
Received: from ns.suse.de ([213.95.15.193]:44036 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264647AbSKSORX>;
	Tue, 19 Nov 2002 09:17:23 -0500
To: Paul Larson <plars@linuxtestproject.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
References: <200211190127.gAJ1RWg11023@linux.local.suse.lists.linux.kernel> <1037713044.24031.15.camel@plars.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 19 Nov 2002 15:24:25 +0100
In-Reply-To: Paul Larson's message of "19 Nov 2002 14:45:46 +0100"
Message-ID: <p73adk5vdra.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson <plars@linuxtestproject.org> writes:

> This has been noticed, I've posted to lkml about it.  The only person
> who replied to me seems to be suggesting it is a hardware issue, but I
> can't believe it is impossible to work around.

It is very hard to solve properly and efficiently. When you search the
list archives you will find long threads about the problem
(search for "TSC" and gettimeofday and perhaps HPET or cyclone). Last one 
was one or two weeks ago.

The problem has been there always in some way in linux, now it is just
exposed in LTP because it tests for it.

-Andi
