Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKJKbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKJKbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 05:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbVKJKbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 05:31:45 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:34177 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750747AbVKJKbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 05:31:44 -0500
Date: Thu, 10 Nov 2005 18:30:32 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Peter Zijlstra <peter@programming.kicks-ass.net>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, riel@redhat.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-ID: <20051110103032.GA10347@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Peter Zijlstra <peter@programming.kicks-ass.net>,
	Nick Piggin <nickpiggin@yahoo.com.au>, riel@redhat.com,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20051109134938.757187000@localhost.localdomain> <20051109141432.393114000@localhost.localdomain> <1131614264.14052.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131614264.14052.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 10:17:44AM +0100, Peter Zijlstra wrote:
> I'm working on a clockpro implementation that essentialy keeps all
> resident pages on 1 clock. In this case readahead pages will also not
> fragment over the active/inactive lists but stay in order. Would that
> also satisfy your requirements?

Thanks, it provides the first guarantee,
and the second one needs an extra bit anyway:
> > - keeps the adjecency of pages in lru;
> > - lifts the page reference counter max from 1 to 3.

> Code can be found at:
>   http://programming.kicks-ass.net/kernel-patches/clockpro-2/

Sorry, I failed connect to it:
ping: unknown host programming.kicks-ass.net

Regards,
Wu
