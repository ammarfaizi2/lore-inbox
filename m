Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUIORLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUIORLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUIORIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:08:53 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:30923 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S266646AbUIOREq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:04:46 -0400
Date: Wed, 15 Sep 2004 13:04:11 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
In-Reply-To: <20040915155555.GA11019@elte.hu>
Message-ID: <Pine.GSO.4.33.0409151300280.10693-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Ingo Molnar wrote:
>yes, but progress in this area seems to have slowed down, and people are
>hurting from the latencies introduced by the BKL meanwhile. Who cares if
>some rare big chunk of code runs under a semaphore, as long as it's
>preemptable?

"as long as it's preemptable" is the key there.  Not all arch's can run
with PREEMPT enabled (yet) -- sparc/sparc64 for but one.  And at the moment,
PREEMPT is a bit on the hosed side.

--Ricky


