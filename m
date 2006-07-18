Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWGRMle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWGRMle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWGRMld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:41:33 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:13245 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751351AbWGRMlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:41:31 -0400
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       pavel@suse.cz, Ulrich Drepper <drepper@redhat.com>
In-Reply-To: <44A12190.40806@linux.intel.com>
References: <1151060089.30819.2.camel@lappy>
	 <20060626095702.8b23263d.akpm@osdl.org>
	 <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org>
	 <20060626223526.GA18579@elte.hu>
	 <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org>
	 <20060627110954.GA23672@elte.hu>  <44A12190.40806@linux.intel.com>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 14:28:59 +0200
Message-Id: <1153225739.2041.18.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So where are we on this? Some ppl (Linus, Ingo) suggested rather
involved solutions that would take some time to mature.

Could we run with the current patch, or one where the sysctl is taken
out and MAX_ARG_PAGES is fixed to PAGE_SIZE/sizeof(void*)?

Peter

