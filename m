Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUIML4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUIML4L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUIML4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:56:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:62648 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263448AbUIML4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:56:08 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@novell.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <1095025000.22893.52.camel@krustophenia.net>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <1095016687.1306.667.camel@krustophenia.net>
	 <20040912192515.GA8165@taniwha.stupidest.org>
	 <20040912193542.GB28791@elte.hu>  <20040912203308.GA3049@dualathlon.random>
	 <1095025000.22893.52.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095072683.14374.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 11:51:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-12 at 22:36, Lee Revell wrote:
> > hence I don't think not allowing nested irqs at all is a good idea and
> > it's a nice feature to support them.
> 
> Agreed.  I was just pointing out that in addition to being a bad idea it
> wouldn't work unless the IDE i/o completion issue is addressed.

Limited nesting is fine and we already have the framework to make it
easy to limit nesting nicely if we want to. Doesn't alter the fact the
IDE one wants looking at once the more serious IDE work is done.

Alan

