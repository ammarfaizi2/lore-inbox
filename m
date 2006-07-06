Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWGFU0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWGFU0c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGFU0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:26:32 -0400
Received: from gw.goop.org ([64.81.55.164]:17291 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750806AbWGFU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:26:31 -0400
Message-ID: <44AD71F7.6050204@goop.org>
Date: Thu, 06 Jul 2006 13:26:31 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linus Torvalds <torvalds@osdl.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com> <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org> <Pine.LNX.4.61.0607062132150.2809@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607062132150.2809@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> $ find linux-2.6.17 -type f -iname '*.[ch]' -print0 | xargs -0 grep 
> volatile | wc -l
> 13948
>
> Tough job.
You need to exclude "asm volatile", which is a completely different thing.

    J
