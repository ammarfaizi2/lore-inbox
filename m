Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUH2RRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUH2RRl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268227AbUH2RRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:17:40 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:43400 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S268216AbUH2RRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:17:09 -0400
Subject: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408291007.50553.jbarnes@engr.sgi.com>
References: <1093786747.1708.8.camel@mulgrave>
	<200408290948.06473.jbarnes@engr.sgi.com>
	<1093798704.10973.15.camel@mulgrave> 
	<200408291007.50553.jbarnes@engr.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 Aug 2004 13:16:47 -0400
Message-Id: <1093799808.10990.22.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 13:07, Jesse Barnes wrote:
> I've up and downed a few CPUs on an Altix, and it seems to work ok, but that's 
> a pretty basic test.  How about this?

Well, like I told Bill.  It's not a priori correct because now you're
altering runtime behaviour.

It may, in fact, work because if the runtime users have an additional
restriction to online cpus, but that's not a given ... have you audited
the code for this?

James


