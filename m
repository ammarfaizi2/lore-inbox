Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269914AbUICWWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269914AbUICWWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 18:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUICWWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 18:22:30 -0400
Received: from holomorphy.com ([207.189.100.168]:63111 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269914AbUICWWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 18:22:23 -0400
Date: Fri, 3 Sep 2004 15:22:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, torvalds@osdl.org,
       jbarnes@engr.sgi.com, colpatch@us.ibm.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: SMP Panic caused by [PATCH] sched: consolidate sched domains]
Message-ID: <20040903222212.GV3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	James Bottomley <James.Bottomley@SteelEye.com>, torvalds@osdl.org,
	jbarnes@engr.sgi.com, colpatch@us.ibm.com, nickpiggin@yahoo.com.au,
	linux-kernel@vger.kernel.org
References: <1094246465.1712.12.camel@mulgrave> <20040903145925.1e7aedd3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903145925.1e7aedd3.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>> Could we get this in please?  The current screw up in the scheduling
>> domain patch means that any architecture that actually hotplugs CPUs
>> will crash in find_busiest_group() ... and I notice this has just bitten
>> the z Series people...

On Fri, Sep 03, 2004 at 02:59:25PM -0700, Andrew Morton wrote:
> Have we yet seen anything which looks like a completed and tested patch?

This is the whole thing; the "other half" referred to a new hunk added to
the patch (identical to this one) posted in its entirety.


-- wli
