Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWH1QIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWH1QIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWH1QIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:08:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2237 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751137AbWH1QIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:08:40 -0400
Date: Mon, 28 Aug 2006 21:38:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: [PATCH 0/4] RCU: various merge candidates
Message-ID: <20060828160845.GB3325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consists of various merge candidates that would
do well to have some testing in -mm. This patchset breaks
out RCU implementation from its APIs to allow multiple
implementations, gives RCU its own softirq and finally
lines up preemptible RCU from -rt tree as a configurable
RCU implementation for mainline.

All comments and testing is welcome. RFC at the moment, but
I can later submit patches against -mm, Andrew, if you want.
They have been tested lightly using dbench, kernbench and ltp
(both CONFIG_CLASSIC_RCU=y and n) on x86 and ppc64.

Thanks
Dipankar
