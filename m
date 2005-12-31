Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVLaJnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVLaJnz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLaJnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:43:55 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.27]:44564 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S932115AbVLaJny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:43:54 -0500
Subject: Re: [PATCH 01/14] page-replace-single-batch-insert.patch
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
In-Reply-To: <20051231070320.GA9997@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
	 <20051230224002.765.28812.sendpatchset@twins.localnet>
	 <20051231070320.GA9997@dmt.cnet>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 10:43:30 +0100
Message-Id: <1136022210.17853.13.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 05:03 -0200, Marcelo Tosatti wrote:
> Hi Peter,
> 
> On Fri, Dec 30, 2005 at 11:40:24PM +0100, Peter Zijlstra wrote:
> > 
> > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > page-replace interface function:
> >   __page_replace_insert()
> > 
> > This function inserts a page into the page replace data structure.
> > 
> > Unify the active and inactive per cpu page lists. For now provide insertion
> > hints using the LRU specific page flags.
> 
> Unification of active and inactive per cpu page lists is a requirement
> for CLOCK-Pro, right? 
> 
> Would be nicer to have unchanged functionality from vanilla VM
> (including the active/inactive per cpu lists).

I guess I could pull all that pcp stuff into page_replace if that would
make you happy ;-)

> Happy new year! 

Best wishes!

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

