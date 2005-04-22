Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVDVPtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVDVPtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVDVPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:49:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55288 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261988AbVDVPtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:49:01 -0400
Date: Fri, 22 Apr 2005 08:48:57 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
In-Reply-To: <20050422073408.GA5470@elte.hu>
Message-ID: <Pine.LNX.4.44.0504220848120.22042-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Is this the PriorityInversionTest (pi_test.tgz) or was there another one?


Daniel


On Fri, 22 Apr 2005, Ingo Molnar wrote:

> 
> > this includes fixes from Daniel Walker, which could fix the plist 
> > related slowdown bugs:
> 
> there are still some problems remaining: i just ran Esben Nielsen's 
> priority-inheritance validation testsuite, and the plist code gives a 
> worst-case latency of 9.0 msecs.
> 
> I've reverted the plist changes for now and have uploaded -46-02 - this 
> gives the expected 1.0 msec worst-case latencies. Diffing -01 against 
> -02 should give you the latest plist snapshot.
> 
> 	Ingo
> 

