Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVHBMnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVHBMnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 08:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVHBMmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 08:42:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24293 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261488AbVHBMka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 08:40:30 -0400
Date: Tue, 2 Aug 2005 14:40:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jack Steiner <steiner@sgi.com>
Subject: Re: [patch 0/2] sched: reduce locking
Message-ID: <20050802124052.GA5879@elte.hu>
References: <42EF65A9.1060408@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EF65A9.1060408@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Hi,
> I've had these patches around for a while, and I'd like to
> get rid of them. They could possibly even go in 2.6.13.

Looks good. Regarding timeline: unless 2.6.13 reopens (due to whatever 
delay), these should not get into 2.6.13 - but they are perfectly fine 
for -mm and for 2.6.14.

	Ingo
