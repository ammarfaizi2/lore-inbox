Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWHCSaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWHCSaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWHCSaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:30:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:15547 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964834AbWHCSaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:30:02 -0400
Subject: Re: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd
	handling fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20060803163302.6D84.Y-GOTO@jp.fujitsu.com>
References: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
	 <20060802233802.8186eb38.akpm@osdl.org>
	 <20060803163302.6D84.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 11:29:56 -0700
Message-Id: <1154629797.5925.21.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 16:47 +0900, Yasunori Goto wrote:
> > > After Keith's report of memory hotadd failure, I increased test patterns.
> > > These patches are a result of new patterns. But I cannot cover all existing
> > > memory layout in the world, more tests are needed.
> > > Now, I think my patch can make things better and want this codes to be tested
> > > in -mm.patche series is consitsts of 5 patches.
> > 
> > I expect the code which these patches touch is completely untested in -mm, so
> > all we'll get is compile testing and some review.
> > 
> > Given that these patches touch pretty much nothing but the memory hot-add
> > paths I'd be inclined to fast-track them into 2.6.18.  Do you agree that
> > these patches are sufficiently safe and that the problems that they solve
> > are sufficiently serious for us to take that approach?
> > 
> > Either way, could I ask that interested parties review this work closely
> > and promptly?
> 
> Hmm. I reviewed them a bit, and I couldn't find any problems.
> 
> However, my ia64 box is same of his. And emulation environment is very
> close too. So, my perspective must be very similar from him.
> I think my review is not enough. Keith-san's test is better if he can.
> 

I will test and review these patches today and will report back.  

Thanks,
  Keith

