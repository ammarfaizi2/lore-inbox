Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263896AbTH1LAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263916AbTH1LAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:00:09 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:12550 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263896AbTH1LAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:00:06 -0400
Subject: Re: [PATCH] Nick's scheduler policy v8
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4DC208.8050606@cyberone.com.au>
References: <3F4DC208.8050606@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1062068387.1200.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 28 Aug 2003 12:59:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-28 at 10:49, Nick Piggin wrote:

> No big changes, this one takes some of the steepness out of the
> timeslice curve and fixes a bug with child priorities which
> might or might not help startup times. Probably no point doing
> any benchmarks on it if they've been done on v7.

I've been playing with it for a while and, from what I've seen until
date, I must say it makes X feel smooth (even when X not reniced,
although I've reniced it to -20). However, it still feels a little bit
slower when forking new processes under heavy load. I'll do some
benchmarking and will post numbers here.
Thanks!

