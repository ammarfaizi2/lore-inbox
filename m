Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272705AbTG1HJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 03:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272706AbTG1HJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 03:09:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61091 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272705AbTG1HJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 03:09:17 -0400
Date: Mon, 28 Jul 2003 09:24:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
In-Reply-To: <200307280003.05185.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0307280921360.3537-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jul 2003, Con Kolivas wrote:

> On Sun, 27 Jul 2003 23:40, Ingo Molnar wrote:
> >  - further increase timeslice granularity
> 
> For a while now I've been running a 1000Hz 2.4 O(1) kernel tree that
> uses timeslice granularity set to MIN_TIMESLICE which has stark
> smoothness improvements in X. I've avoided promoting this idea because
> of the theoretical drop in throughput this might cause. I've not been
> able to see any detriment in my basic testing of this small granularity,
> so I was curious to see what you throught was a reasonable lower limit?

it's a hard question. The 25 msecs in -G6 is probably too low.

	Ingo

