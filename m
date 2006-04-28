Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWD1WZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWD1WZN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWD1WZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:25:13 -0400
Received: from smtp-1.llnl.gov ([128.115.3.81]:56222 "EHLO smtp-1.llnl.gov")
	by vger.kernel.org with ESMTP id S1751773AbWD1WZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:25:11 -0400
From: Dave Peterson <dsp@llnl.gov>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Date: Fri, 28 Apr 2006 15:24:19 -0700
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       nickpiggin@yahoo.com.au, ak@suse.de, pj@sgi.com
References: <200604271308.10080.dsp@llnl.gov> <200604281459.27895.dsp@llnl.gov> <20060428151638.32ca188e.akpm@osdl.org>
In-Reply-To: <20060428151638.32ca188e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281524.19425.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 April 2006 15:16, Andrew Morton wrote:
> Dave Peterson <dsp@llnl.gov> wrote:
> > Yes I am familiar with this sort of problem.  :-)
>
> Andrea has long advocated that the memory allocator shouldn't infinitely
> loop for small __GFP_WAIT allocations.  ie: ultimately we should return
> NULL back to the caller.
>
> Usually this will cause the correct process to exit.  Sometimes it won't.
>
> Did you try it?

Haven't tried it yet.  Sounds like a good idea.
