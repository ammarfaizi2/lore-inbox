Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUKBVcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUKBVcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUKBVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:31:57 -0500
Received: from fmr04.intel.com ([143.183.121.6]:38295 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261976AbUKBVbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:31:07 -0500
Message-Id: <200411022126.iA2LQIq17357@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Theurer'" <habanero@us.ibm.com>, <kernel@kolivas.org>,
       <ricklind@us.ibm.com>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH] sched: aggressive idle balance
Date: Tue, 2 Nov 2004 13:29:52 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcTBGQamiIpc72EvSHmRPO0laO+SkAACaPqQ
In-Reply-To: <200411021416.38119.habanero@us.ibm.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote on Tuesday, November 02, 2004 12:17 PM
>
> So far we have seen 3-5% with these patches on online transaction workolads
> and no regressions on SDET.  Kenneth, I am particularly interested in using
> this with your increased cache_hot_time value, where you got your best
> throughput:
>
> ...but still had idle time.  Do you think you could try these patches with
> your 25ms cache_hot_time?  I think your workload could benefit from both the
> longer cache_hot_time for busy cpus, but more aggressive idle balances,
> hopefully driving your workload to 100% cpu utilization.

Looks interesting, I will queue this up on our benchmark setup.

- Ken


