Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVIGQKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVIGQKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVIGQKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:10:34 -0400
Received: from palrel10.hp.com ([156.153.255.245]:34988 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S932155AbVIGQKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:10:33 -0400
Date: Wed, 7 Sep 2005 09:14:23 -0700
From: Grant Grundler <iod00d@hp.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Prefetch kernel stacks to speed up context switch
Message-ID: <20050907161423.GA30660@esmail.cup.hp.com>
References: <200509070829.j878TSg25898@unix-os.sc.intel.com> <2cd57c900509070152518fac06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900509070152518fac06@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 04:52:17PM +0800, Coywolf Qi Hunt wrote:
> On 9/7/05, Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> > Repost previously discussed patch (on Jul 27, 2005).

For reference:
http://www.gelato.unsw.edu.au/archives/linux-ia64/0507/14686.html

> Do you have any benchmarks?

Have you read the discussion?
See:
    http://www.gelato.unsw.edu.au/archives/linux-ia64/0507/14685.html

Ken didn't post any benchmark results originally but clearly
stated the cacheline misses were occurring enough to be measurable.
Just knowing which workload and how much much time was spent
stalling for cacheline misses should be sufficient.

grant
