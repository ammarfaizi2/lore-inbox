Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263021AbTCSLbE>; Wed, 19 Mar 2003 06:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263022AbTCSLbE>; Wed, 19 Mar 2003 06:31:04 -0500
Received: from holomorphy.com ([66.224.33.161]:16003 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263021AbTCSLbD>;
	Wed, 19 Mar 2003 06:31:03 -0500
Date: Wed, 19 Mar 2003 03:41:44 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.65-1
Message-ID: <20030319114144.GA1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1) PCI DMA fix (zwane probably did it and I accidentally dropped it later)
(2) brute-force merge to 2.5.65

Given the brutality of the merge I wouldn't be surprised by a few bugs.

The stronger antifragmentation heuristics are still being debugged.
I wouldn't expect very good performance until they're sorted out.

Also, badari's working on a fix for q->max_sectors*512 < PAGE_SIZE for
fs/mpage.c and possibly others. If anyone besides me and badari are
interested in that, either he or I will send the patch out for review.

Tested on 48GB NUMA-Q only (successfully so). No testing elsewhere yet.

Non-incremental vs. virgin 2.5.65.

As usual, available from
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
