Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266546AbUGVSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUGVSaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266875AbUGVSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:30:20 -0400
Received: from peabody.ximian.com ([130.57.169.10]:34440 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S266546AbUGVSaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:30:16 -0400
Subject: Re: voluntary-preempt I0: sluggish feel
From: Robert Love <rml@ximian.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Rudo Thomas <rudo@matfyz.cz>
In-Reply-To: <20040722180142.GC30059@elte.hu>
References: <20040721082218.GA19013@elte.hu>
	 <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys>
	 <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys>
	 <20040722100657.GA14909@elte.hu>
	 <20040722160055.GA4837@ss1000.ms.mff.cuni.cz>
	 <20040722161941.GA23972@elte.hu>
	 <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
	 <20040722175457.GA5855@ss1000.ms.mff.cuni.cz>
	 <20040722180142.GC30059@elte.hu>
Content-Type: text/plain
Date: Thu, 22 Jul 2004 14:31:22 -0400
Message-Id: <1090521082.27464.34.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 20:01 +0200, Ingo Molnar wrote:

> i can reproduce this and i dont have the NVIDIA driver. When logging in
> over the network then shell output is chunky with a setting of 2
> (softirq redirection), shell output is smooth with a value of 1.

Almost certainly the fact that ksoftirqd runs as nice 19.

	Robert Love


