Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbTE1Iow (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 04:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTE1Iov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 04:44:51 -0400
Received: from 61-222-245-236.HINET-IP.hinet.net ([61.222.245.236]:20352 "EHLO
	alpha1.infor.org") by vger.kernel.org with ESMTP id S264618AbTE1Iou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 04:44:50 -0400
Date: Wed, 28 May 2003 16:57:56 +0800 (CST)
From: steelgate <steelgate@alpha1.infor.org>
To: linux-kernel@vger.kernel.org
cc: linux-smp@vger.kernel.org
Subject: kernel 2.5.70 oops on alpha
Message-ID: <Pine.LNX.4.55.0305281656490.3009@alpha1.infor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting kernel 2.5.70, I've got following messages:
(Running on a Compaq DS20(Tsunami with 8 D chips)
 with 2 Alpha EV6 CPUs@500MHz,
 configured with alpha system type: DP264, SMP enabled;
 compiled with gcc-3.2.3
 The same kernel configuration runs fine on 2.5.68)

task migrationcache decay timeout: 0 msecs.
SMP starting up secondaries.
Starting migration thread for cpu 0
Briniging up 1
Unable to handle paging request at virtual address 0000000000000000
CPU 0 swapper(1): Oops 0
pc = [<fffffc00012d1c04>] ra = [<fffffc00012ce690>] ps = 0007        Not tained
v0 = 0000000000000000 t0 = 0000000000000000 t1 = 0000000000000001
t2 = 0000000000000000 t3 = fffffc000132e080 t4 = fffffc000132e080
t5 = fffffc000132f3c0 t6 = fffffc000138bfc0 t7 = fffffc00034b8000
s0 = fffffc000138bfc0 s1 = 0000000000000001 s2 = fffffc00012f0db8
s3 = fffffc00013e1458 s4 = fffffc00013e0558 s5 = 0000000000000001
s6 = fffffc00034bba50
a0 = 0000000000000007 a1 = 0000000000000001 a2 = 0000000000000000
a3 = 0000000000000000 a4 = fffffc003ff52618 a5 = fffffc00034bb970
t8 = 0000000000000000 t9 = fffffc000138c1e0 t10 = 0000000000000000
t11 = 0000000000000000 pv = fffffc00012d1b40 at = 0000000000000000
gp = fffffc00013e0db8 sp = fffffc00034bba50
Trace:fffffc00010101d0 fffffc00102d858 fffffc00010100a4 fffffc0001012eb0 fffffc
000102d9ac fffffc000102d9ac fffffc000102d858 fffffc0010100a4 fffffc0001010150 f
ffffc001013250
Code: 2042ffff b4450008 a4270000 402055a1 f4200038 a4670048 <a0230000> 2021
ffff
Kernel panic: Attemped to kill init!

