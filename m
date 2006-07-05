Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWGEOE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWGEOE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 10:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWGEOE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 10:04:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:12739 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964876AbWGEOEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 10:04:55 -0400
Date: Wed, 5 Jul 2006 16:04:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
cc: Peter Williams <pwil3058@bigpond.net.au>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] sched: Add SCHED_BGND (background) scheduling policy
In-Reply-To: <20060705080539.GA22099@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.61.0607051603560.447@yvahk01.tjqt.qr>
References: <20060704233521.8744.45368.sendpatchset@heathwren.pw.nest>
 <200607051014.48089.kernel@kolivas.org> <44AB0CA2.5080908@bigpond.net.au>
 <20060705080539.GA22099@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Peter
>> PS Any programs that use SCHED_IDLEPRIO should work as long as its value 
>> is defined as 4.
>
>OK, nice, but:
>
>2.6.17-ck1:
>
>/*
> * Scheduling policies
> */
>#define SCHED_NORMAL            0
>#define SCHED_FIFO              1
>#define SCHED_RR                2
>#define SCHED_BATCH             3
>#define SCHED_ISO               4
>#define SCHED_IDLEPRIO          5
>
>#define SCHED_MIN               0
>#define SCHED_MAX               5
>
>
>Arggl.
>
>So what does that tell us?
>

We need a common header now.


Jan Engelhardt
-- 
