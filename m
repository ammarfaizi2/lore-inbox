Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUBWA77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUBWA77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:59:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:36326 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbUBWA75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:59:57 -0500
Date: Sun, 22 Feb 2004 17:00:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: cw@f00f.org, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040222170032.0219ea67.akpm@osdl.org>
In-Reply-To: <40394F61.8060509@cyberone.com.au>
References: <20040222033111.GA14197@dingdong.cryptoapps.com>
	<4038299E.9030907@cyberone.com.au>
	<40382BAA.1000802@cyberone.com.au>
	<4038307B.2090405@cyberone.com.au>
	<40383300.5010203@matchmail.com>
	<4038402A.4030708@cyberone.com.au>
	<40384325.1010802@matchmail.com>
	<403845CB.8040805@cyberone.com.au>
	<20040221221721.42e734d6.akpm@osdl.org>
	<40384D9D.6040604@cyberone.com.au>
	<20040222083637.GA15589@dingdong.cryptoapps.com>
	<20040222011350.58f756e8.akpm@osdl.org>
	<40394662.5060104@cyberone.com.au>
	<20040222162634.560c5306.akpm@osdl.org>
	<40394A9F.1050606@cyberone.com.au>
	<20040222164617.7fba4321.akpm@osdl.org>
	<40394F61.8060509@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> 
> >
> >yep.
> >
> >
> 
> Yeah this is good. I thought the patch you were proposing was
> to shrink slab on highmem pressure.

That as well.

> Apply some lowmem pressure due to highmem pressure THEN shrink
> slab as a result of the lowmem pressure is much better.

Prove it to me ;)
