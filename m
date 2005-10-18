Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVJRIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVJRIsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVJRIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:48:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:33182 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932425AbVJRIsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:48:09 -0400
Message-ID: <4354B6CD.20907@de.ibm.com>
Date: Tue, 18 Oct 2005 10:48:13 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>, holt@sgi.com, greg@kroah.com,
       haveblue@us.ibm.com, linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com, nickpiggin@yahoo.com.au, steiner@americas.sgi.com,
       mschwid2@de.ibm.com
Subject: Re: [Patch 2/3] Export get_one_pte_map.
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com>	<20051014192225.GD14418@lnx-holt.americas.sgi.com>	<20051014213038.GA7450@kroah.com>	<20051017113131.GA30898@lnx-holt.americas.sgi.com>	<1129549312.32658.32.camel@localhost>	<20051017114730.GC30898@lnx-holt.americas.sgi.com>	<Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com>	<20051017151430.GA2564@lnx-holt.americas.sgi.com>	<20051017152034.GA32286@kroah.com>	<20051017155605.GB2564@lnx-holt.americas.sgi.com>	<Pine.LNX.4.61.0510171700150.4934@goblin.wat.veritas.com> <20051017135314.3a59fb17.akpm@osdl.org>
In-Reply-To: <20051017135314.3a59fb17.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ther are nearly 100 mm patches in -mm.  I need to do a round of discussion
> with the originators to work out what's suitable for 2.6.15.  For "Hugh
> stuff" I'm thinking maybe the first batch
> (mm-hugetlb-truncation-fixes.patch to mm-m68k-kill-stram-swap.patch) and
> not the second batch.  But we need to think about it.
We tested Hugh's stuff that is currently in -mm, mainly from the xip
perspecive. Seems to work fine for 390.
