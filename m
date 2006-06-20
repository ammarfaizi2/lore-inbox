Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWFTXKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWFTXKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 19:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWFTXK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 19:10:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:32716 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751848AbWFTXKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 19:10:23 -0400
Subject: Re: [patch 0/3] 2.6.17 radix-tree: updates and lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20060620153555.0bd61e7b.akpm@osdl.org>
References: <20060408134635.22479.79269.sendpatchset@linux.site>
	 <20060620153555.0bd61e7b.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:09:49 +1000
Message-Id: <1150844989.1901.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 15:35 -0700, Andrew Morton wrote:

> So given those complexities, and the lack of a _user_ of
> radix-tree-rcu-lockless-readside.patch, it doesn't look like 2.6.18 stuff
> at this time.

So what should I do ? leave the bug in ppc64 or kill it's scalability
when taking interrupts ? You have one user already, me. From what Nick
says, the patch has been beaten up pretty heavily and seems stable....

Ben.


