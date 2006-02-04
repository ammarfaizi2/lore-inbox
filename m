Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946256AbWBDBXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946256AbWBDBXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 20:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946257AbWBDBXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 20:23:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:395 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946256AbWBDBXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 20:23:01 -0500
Date: Fri, 3 Feb 2006 17:22:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com, shai@scalex86.org,
       alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 0/3] NUMA slab locking fixes
Message-Id: <20060203172218.7fb62e21.akpm@osdl.org>
In-Reply-To: <20060204010857.GG3653@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain>
	<20060203140748.082c11ee.akpm@osdl.org>
	<Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com>
	<20060204010857.GG3653@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> PS: Many hotplug fixes are yet to be applied upstream I think.  I know
>  these slab patches work well with mm4 (with the x86_64 subtree and hotplug 
>  fixes in there) but I cannot really test cpu_up after cpu_down on rc2 
>  because it is broken as of now (pending merges, I guess).

Yes, -rc2 was a shade too early for me to complete merging stuff.  Current
-linus should be better.
