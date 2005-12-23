Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbVLWDRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbVLWDRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 22:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVLWDRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 22:17:12 -0500
Received: from mtai04.charter.net ([209.225.8.184]:16512 "EHLO
	mtai04.charter.net") by vger.kernel.org with ESMTP id S1030391AbVLWDRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 22:17:11 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
Message-ID: <43AB6B89.8020409@cybsft.com>
Date: Thu, 22 Dec 2005 21:14:17 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc5-rt4: BUG: swapper:0 task might have lost a preemption
 check!
References: <1135306534.4473.1.camel@mindpipe>
In-Reply-To: <1135306534.4473.1.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Got this on boot.  Same .config as the last one I sent you.
> 
> VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
>     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide1...
> BUG: swapper:0 task might have lost a preemption check!
>  [<c010440c>] dump_stack+0x1c/0x20 (20)
>  [<c01166aa>] preempt_enable_no_resched+0x5a/0x60 (20)
>  [<c0100dd9>] cpu_idle+0x79/0xb0 (12)
>  [<c0100280>] _stext+0x40/0x50 (28)
>  [<c03078e6>] start_kernel+0x176/0x1d0 (20)
>  [<c0100199>] 0xc0100199 (1086889999)
> ---------------------------
> | preempt count: 00000000 ]
> | 0-level deep critical section nesting:
> ----------------------------------------
> 
> Lee
> 

I have been getting this on my SMP system. I have yet to get a
successful boot. I have been looking with every spare minute I have had
for a couple of days, but have yet to find the problem. :(


-- 
   kr
