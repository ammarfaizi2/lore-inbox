Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSLGPRl>; Sat, 7 Dec 2002 10:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSLGPRl>; Sat, 7 Dec 2002 10:17:41 -0500
Received: from gen3-newburypark5-192.vnnyca.adelphia.net ([207.175.226.192]:48888
	"EHLO dave.home") by vger.kernel.org with ESMTP id <S262779AbSLGPRk>;
	Sat, 7 Dec 2002 10:17:40 -0500
Date: Sat, 7 Dec 2002 07:25:16 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200212071525.gB7FPGn00204@dave.home>
To: linux-kernel@vger.kernel.org
Subject: RE: 2.4.18 beats 2.5.50 in hard drive access????
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manish Lachwani (manish@Zambeel.com) wrote:
>Can you also make sure that write cache is ON? hdparm -q -W 1 /dev/hdX. And 
>also the READ cache. hdparm -q -A 1 /dev/hdX. 
>
>Also, from the IDENTIFY information below, it looks like no UDMA mode is set 
>for the device. It always is set to multiword dma 2.

I tried both hdparm commands on hdb/hdc/hdd and they didn't print out any
errors, but the performance hasn't changed any. I'm only concerned with
scattered read access performance, write performance is fairly irrelevant.

Is the lack of a UDMA mode related to the kernel message of "DMA disabled"?

Thanks--
Dave
