Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUILTkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUILTkv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268831AbUILTkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:40:51 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:36555 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268824AbUILTkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:40:49 -0400
Date: Sun, 12 Sep 2004 12:40:36 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Arjan van de Ven <arjanv@redhat.com>,
       Andrea Arcangeli <andrea@novell.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040912194036.GA8391@taniwha.stupidest.org>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912193542.GB28791@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 09:35:42PM +0200, Ingo Molnar wrote:

> no. A 2 msec nonpreemptable delay is a 2 msec delay, irqs on or off
> alike.

maybe im retarded, 2ms seems like a long time --- is this strictly
necessary on modern chipsets?  surely we can fix the code to not do
this for most people without hosing their data?

> but it's not a big problem with IRQ threading, there most hardirqs
> are preemptable.

most?  what determines which and when?
