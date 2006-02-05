Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946171AbWBEG23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946171AbWBEG23 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 01:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946172AbWBEG23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 01:28:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:56751 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946171AbWBEG23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 01:28:29 -0500
Date: Sat, 4 Feb 2006 22:28:12 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@engr.sgi.com, steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] cpuset memory spread page cache implementation and
 hooks
Message-Id: <20060204222812.d7e00d26.pj@sgi.com>
In-Reply-To: <20060204221524.1607401e.akpm@osdl.org>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071915.10021.89936.sendpatchset@jackhammer.engr.sgi.com>
	<20060204154953.35a0f63f.akpm@osdl.org>
	<20060204174252.9390ddc6.pj@sgi.com>
	<20060204175411.19ff4ffb.akpm@osdl.org>
	<Pine.LNX.4.62.0602041928140.8874@schroedinger.engr.sgi.com>
	<20060204210653.7bb355a2.akpm@osdl.org>
	<20060204220800.049521df.pj@sgi.com>
	<20060204221524.1607401e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> If so then there's probably not much point in optimising it - but one needs
> to look at the numbers.

Ok - I'll play around with it.

> Please also have a think about __cache_alloc() ..

I'll give it shot - no telling if I'll hit anything yet.

> but one needs to look at the numbers.

Definitely.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
