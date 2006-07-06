Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWGFUzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWGFUzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbWGFUzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:55:45 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:14724 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750851AbWGFUzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:55:44 -0400
Date: Thu, 6 Jul 2006 22:55:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <44AD71F7.6050204@goop.org>
Message-ID: <Pine.LNX.4.61.0607062252350.10657@yvahk01.tjqt.qr>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607062132150.2809@yvahk01.tjqt.qr> <44AD71F7.6050204@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> $ find linux-2.6.17 -type f -iname '*.[ch]' -print0 | xargs -0 grep
>> volatile | wc -l
>> 13948
>> 
>> Tough job.
>
> You need to exclude "asm volatile", which is a completely different thing.

10077.


Jan Engelhardt
-- 
