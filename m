Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133027AbRDZBKZ>; Wed, 25 Apr 2001 21:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbRDZBKF>; Wed, 25 Apr 2001 21:10:05 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:25218 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S133027AbRDZBKD>;
	Wed, 25 Apr 2001 21:10:03 -0400
Date: Wed, 25 Apr 2001 21:09:57 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
To: <linux-kernel@vger.kernel.org>
cc: Feng Xian <fxian@chrysalis-its.com>
Subject: __alloc_pages: 4-order allocation failed
Message-ID: <Pine.LNX.4.30.0104252059430.5253-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am running linux-2.4.3 on a Dell dual PIII machine with 128M memory.
After the machine runs a while, dmesg shows,

__alloc_pages: 4-order allocation failed.
__alloc_pages: 3-order allocation failed.
__alloc_pages: 4-order allocation failed.
__alloc_pages: 4-order allocation failed.
__alloc_pages: 4-order allocation failed.
__alloc_pages: 4-order allocation failed.


and sometime the system will crash. I looked into the memory info,
there still has some free physical memory (20M) left and swap space is
almost not in use. (250M swap)

I didn't have this problem when I ran 2.4.0 (I even didn't see it on
2.4.2) could anybody tell me what's wrong or where should I look into this
problem?

Thanks,

Alex

-- 
Feng Xian

