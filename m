Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTKFIGC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTKFIGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:06:02 -0500
Received: from bay4-f41.bay4.hotmail.com ([65.54.171.41]:1042 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263412AbTKFIGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:06:00 -0500
X-Originating-IP: [202.172.55.22]
X-Originating-Email: [slashboy84@msn.com]
From: "Wee Teck Neo" <slashboy84@msn.com>
To: linux-kernel@vger.kernel.org
Subject: Over used cache memory?
Date: Thu, 06 Nov 2003 16:05:59 +0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY4-F41WYf5UPHvAo10001c90f@hotmail.com>
X-OriginalArrivalTime: 06 Nov 2003 08:05:59.0424 (UTC) FILETIME=[D02F0000:01C3A43C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system having 1GB ram and this is the output of vmstat

   procs                      memory      swap          io     system      
cpu
r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id
0  0  0   5640  21224 121512 797832    0    0     6     9    3    17  0  0  
6


It seems that 797MB is used for caching... thats a high number. Anyway to 
set a lower cache size?

I've read about the /proc/sys/vm/buffermem but my /proc doesn't have it.

Kernel: 2.4.22

_________________________________________________________________
Get 10mb of inbox space with MSN Hotmail Extra Storage 
http://join.msn.com/?pgmarket=en-sg

