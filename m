Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTLBBD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 20:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTLBBD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 20:03:57 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3340
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264264AbTLBBD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 20:03:56 -0500
Date: Mon, 1 Dec 2003 17:03:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: pinotj@club-internet.fr
Cc: manfred@colorfullife.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031202010352.GM1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: pinotj@club-internet.fr, manfred@colorfullife.com,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <mnet1.1069958559.15912.pinotj@club-internet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mnet1.1069958559.15912.pinotj@club-internet.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 27, 2003 at 07:42:39PM +0100, pinotj@club-internet.fr wrote:
> first, some news
> 
> 2.6.0-test11 makes same oops during second compilation of kernel. The vanilla kernel with PREEMPT always oops the same way. No matter, it's always reproductible.
> 
> 2.6.0-test11 + Manfred's patch doesn't hang but I found a slab error in the logs that occured during a compilation. (I didn't find this for -test10, I was lucky ?)
> 
> So, there is no more way for my system to run a kernel > -test9 without problem.

Can you try some of the test9-bkN kernels and see where the problem starts?
