Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVIMVcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVIMVcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVIMVcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:32:20 -0400
Received: from fmr24.intel.com ([143.183.121.16]:17560 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932312AbVIMVcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:32:20 -0400
Message-Id: <200509132132.j8DLWJg04553@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: Quick update on latest Linux kernel performance
Date: Tue, 13 Sep 2005 14:32:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcW4qp6p2qlAC0rOR5SlrDiNOxRCag==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New performance result are posted on http://kernel-perf.sourceforge.net
with latest data collected on kernel 2.6.13-git9.

Kernel-build bench are fairly stable over the last 14 kernel versions
or so.  It was consistently 3-5% better on x86_64 over baseline 2.6.9
kernel.  It showed a lot smaller gain on ia64 though.

Java business benchmark showed very little change in performance on all
kernel versions.

Volanomark took some heavy performance hit during 2.6.12-rc* period, but
come back in 2.6.13 on x86_64 configuration.  Though latest 2.6.13-git9
showed a little bit perf. regression.

Netperf is showing wildly result, especially the 1-byte request/response
component.  Overall, UDP portion Of the netperf are showing nice improvement
over baseline 2.6.9 kernel.

Industry standard transaction processing database workload still suffering
13% performance regression with 2.6.13. (data will be posted in a separate mail)

Take a look at the performance data.  Comments and suggestions are always
welcome and please post them to LKML.


