Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUILTZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUILTZy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUILTZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:25:54 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:13441 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268819AbUILTZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:25:52 -0400
Date: Sun, 12 Sep 2004 12:25:15 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@novell.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040912192515.GA8165@taniwha.stupidest.org>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095016687.1306.667.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 03:18:07PM -0400, Lee Revell wrote:

> The glaring exception is the IDE io completion, which can run for
> 2000+ usec even with a modern chipset and drive.

does un-masking irqs help?
