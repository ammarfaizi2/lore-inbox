Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTDPSSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTDPSSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:18:25 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:10222 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S264509AbTDPSSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:18:24 -0400
Date: Wed, 16 Apr 2003 11:30:17 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DMA Timeouts with 3112 SATA Controller (status == 0x21)
Message-ID: <Pine.LNX.4.33.0304161129570.19725-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>while. The following errors were displayed on the console:
>>
>>    hde: dma_timer_expiry: dma_status == 0x21
>>    hde: timeout waiting for DMA

> On Saturday I tried a Seagate 120GiB SATA with my onboard SiI3112 on
> my ASUS P4G8X (with an Intel 7205 chipset). I suppose that David is

I am seeing the same problems with SiI3112 chipset adapters in a 
Supermicro motherboard with 7501 chipset.

I get the DMA timeouts after merely enabling DMA with hdparm- I never even 
get a chance to write anything to disk.

> somehow related to this chipset: I saw the exact same errors as David.
> I also tried several kernels: 2.4.20-ac2, 2.4.20-pre5-ac3, 2.4.20-pre7,
> 2.5.66, 2.4.20-8 from Redhat 9, ... with exactly the same result.

Same here.  I haven't seen DMA working with this chip yet.





