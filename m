Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269003AbUICOtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269003AbUICOtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUICOtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:49:08 -0400
Received: from jade.spiritone.com ([216.99.193.136]:32671 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S269003AbUICOtG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:49:06 -0400
Date: Fri, 03 Sep 2004 07:48:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>, Keith Owens <kaos@sgi.com>
Subject: Re: [PATCH][0/8] Arch agnostic completely out of line locks
Message-ID: <393510000.1094222920@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.58.0409020905540.4481@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409020905540.4481@montezuma.fsmlabs.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch achieves out of line spinlocks by creating kernel/spinlock.c
> and using the _raw_* inline locking functions.
... 
> Size differences are with CONFIG_PREEMPT enabled since we wanted to
> determine how much could be saved by moving that lot out of line too.

So does this have no performance impact at all? or has that not been measured?

M.

