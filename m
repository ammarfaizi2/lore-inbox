Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbUKZTrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbUKZTrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUKZTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:47:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262500AbUKZT2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:28:50 -0500
Date: Thu, 25 Nov 2004 23:08:17 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041125165829.GA24121@elte.hu>
Message-Id: <Pine.OSF.4.05.10411252305040.25041-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2004, Ingo Molnar wrote:

> [...] 
> 
> yeah, i agree that this has to be further investigated. What type of box
> did you test it on - UP or SMP? (SMP scheduling of RT tasks only got
> fully correct in the very latest -31-7 kernel.)
> 

I am running on -31-7 kernel now - it takes quite some time to run with
the runall.sh script with 100000 samples per point so I don't have full
data yet. But the bounds look like
 depth observed bound  theoretical
   1        1 ms          1 ms
   2        3 ms          2 ms      :-(

the rest of the list will follow tomorrow...

> 	Ingo
> 

Esben

