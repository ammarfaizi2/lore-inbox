Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270093AbTG1PBw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 11:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270190AbTG1PBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 11:01:52 -0400
Received: from math.ut.ee ([193.40.5.125]:43659 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S270093AbTG1PBv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 11:01:51 -0400
Date: Mon, 28 Jul 2003 18:17:00 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: raid5 autoselecting a slower checksum function
Message-ID: <Pine.GSO.4.44.0307281811290.13144-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is 2.6.0-test2 on a Celeron 900:

raid5: measuring checksumming speed
   8regs     :  1640.000 MB/sec
   8regs_prefetch:  1316.000 MB/sec
   32regs    :   824.000 MB/sec
   32regs_prefetch:   788.000 MB/sec
   pIII_sse  :  1744.000 MB/sec
   pII_mmx   :  2244.000 MB/sec
   p5_mmx    :  2400.000 MB/sec
raid5: using function: pIII_sse (1744.000 MB/sec)

Why doesn't it select p5_mmx if it is 37% faster than pIII_sse?

-- 
Meelis Roos (mroos@linux.ee)


