Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVFGXuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVFGXuI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVFGXuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:50:08 -0400
Received: from bay102-f24.bay102.hotmail.com ([64.4.61.34]:18120 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262040AbVFGXuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:50:04 -0400
Message-ID: <BAY102-F24530D3EE13EBCA2B13336A0FA0@phx.gbl>
X-Originating-IP: [64.4.61.200]
X-Originating-Email: [hzmonte@hotmail.com]
From: "helen monte" <hzmonte@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: How does 2.6 SMP scheduler initially assign a thread to a run queue?
Date: Tue, 07 Jun 2005 23:50:03 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 07 Jun 2005 23:50:03.0523 (UTC) FILETIME=[9FDFD530:01C56BBB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.6 kernel, there is one run queue per CPU, in case of an SMP.
After a thread is created, how does the scheduler determine which run
queue it goes to?  I know that once it goes to a particular run queue,
the scheduler would try to run that thread on that CPU to take
advantage of processor affinity; and then there would be the load
balancing stuff.  But at the very beginning, what algorithm does the
scheduler use to assign a newly created thread to a particulat CPU?
Would the load balancing algorithm be used? Or gang scheduling?
By the way, in an SMT/hyperthreading processor, does the latest kernel
version assign one run queue per physical CPU, or per virtual processor?


