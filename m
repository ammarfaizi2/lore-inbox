Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUKWI2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUKWI2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbUKWI2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:28:08 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:54543 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S262328AbUKWI2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:28:05 -0500
Message-ID: <41A2F3C0.90400@mrv.com>
Date: Tue, 23 Nov 2004 10:24:32 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
References: <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <41A1A6E6.5090807@mrv.com> <20041122100140.GD6817@elte.hu> <41A1EAE0.9080504@mrv.com> <20041122144248.GB28211@elte.hu>
In-Reply-To: <20041122144248.GB28211@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Eran Mann <emann@mrv.com> wrote:
> 
>>Right on.
>>After hdparm -d0 I see maximum latency of 35 us after a full kernel 
>>build with a few GUI apps in the background. I´ll try to find a 
>>reasonable compromise.
> 
> it might make sense to report this to the hw vendor as well, as these
> latencies dont occur at _every_ IDE DMA, it might be some sort of
> chipset (or BIOS) bug they might want to see resolved as well (if this
> isnt a ship-and-forget vendor). 2 msec stalls are not nice to a fair
> number of applications.
> 
> 	Ingo

It´s a rather old white-box machine with a noname VIA-based motherboard, 
So I don´t really have whom to report the problem to. On the other hand 
with udma2 I see latencies < 170 us which seems reasonable.
Thanks for the advice.
   Eran.
