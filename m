Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVC1Tdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVC1Tdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVC1Tdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:33:39 -0500
Received: from fmr21.intel.com ([143.183.121.13]:64952 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262011AbVC1Tdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:33:33 -0500
Message-Id: <200503281933.j2SJXJg22526@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Industry db benchmark result on recent 2.6 kernels
Date: Mon, 28 Mar 2005 11:33:19 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUzzP8FjHKuleJxSwyQ3HehlVVT4Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The roller coaster ride continues for the 2.6 kernel on how it measure
up in performance using industry standard database transaction processing
benchmark.  We took a measurement on 2.6.11 and found it is 13% down from
the baseline.

We will be taking db benchmark measurements more frequently from now on with
latest kernel from kernel.org (and make these measurements on a fixed interval).
By doing this, I hope to achieve two things: one is to track base kernel
performance on a regular base; secondly, which is more important in my opinion,
is to create a better communication flow to the kernel developers and to keep
all interested party well informed on the kernel performance for this enterprise
workload.

With that said, here goes our first data point along with some historical data
we have collected so far.

2.6.11	-13%
2.6.9		- 6%
2.6.8		-23%
2.6.2		- 1%
baseline	(rhel3)

The glory detail on the benchmark configuration: 4-way SMP, 1.6 GHz Intel
itanium2, 64GB memory, 450 73GB 15k-rpm disks.  All experiments were done
With exact same hardware and application software, except different kernel
versions.


