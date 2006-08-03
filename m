Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWHCHsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWHCHsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWHCHsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:48:18 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5321 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932369AbWHCHsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:48:18 -0400
Date: Thu, 03 Aug 2006 16:47:21 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd handling fix
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       kmannth@us.ibm.com
In-Reply-To: <20060802233802.8186eb38.akpm@osdl.org>
References: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com> <20060802233802.8186eb38.akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060803163302.6D84.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After Keith's report of memory hotadd failure, I increased test patterns.
> > These patches are a result of new patterns. But I cannot cover all existing
> > memory layout in the world, more tests are needed.
> > Now, I think my patch can make things better and want this codes to be tested
> > in -mm.patche series is consitsts of 5 patches.
> 
> I expect the code which these patches touch is completely untested in -mm, so
> all we'll get is compile testing and some review.
> 
> Given that these patches touch pretty much nothing but the memory hot-add
> paths I'd be inclined to fast-track them into 2.6.18.  Do you agree that
> these patches are sufficiently safe and that the problems that they solve
> are sufficiently serious for us to take that approach?
> 
> Either way, could I ask that interested parties review this work closely
> and promptly?

Hmm. I reviewed them a bit, and I couldn't find any problems.

However, my ia64 box is same of his. And emulation environment is very
close too. So, my perspective must be very similar from him.
I think my review is not enough. Keith-san's test is better if he can.

Anyway, I'll test them with -mm. Something different environment
may be good for test.

Thanks.


-- 
Yasunori Goto 


