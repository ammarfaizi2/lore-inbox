Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSDVSoi>; Mon, 22 Apr 2002 14:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSDVSoh>; Mon, 22 Apr 2002 14:44:37 -0400
Received: from zero.tech9.net ([209.61.188.187]:52233 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314417AbSDVSog>;
	Mon, 22 Apr 2002 14:44:36 -0400
Subject: Re: [PATCH] 2.4-ac updated O(1) scheduler
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1019350197.9288.197.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 22 Apr 2002 14:44:40 -0400
Message-Id: <1019501081.940.36.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-20 at 20:49, Robert Love wrote:

> The attached patch updates Ingo Molnar's ultra-scalable O(1) scheduler
> in 2.4-ac to the latest code base.  It contains various fixes, cleanups,
> and new features.  All changes are from 2.5 or patches pending for 2.5.

There is an updated patch at

	http://www.kernel.org/pub/linux/kernel/people/rml/sched/ingo-O1/sched-fixes-O1-rml-2.4.19-pre7-ac2-2.patch

and your favorite mirror.  With the following changes:

	- include linux/interrupt.h in sched.c
	- use yield() where appropriate, not the old method

which are boring and only needed for those with compile problems.

	Robert Love

