Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265253AbUENL0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbUENL0y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUENL0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:26:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60630 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265253AbUENLZs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:25:48 -0400
Date: Fri, 14 May 2004 13:24:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: raghav@in.ibm.com, akpm@osdl.org, maneesh@in.ibm.com, dipankar@in.ibm.com,
       torvalds@osdl.org, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040514112408.GH17326@suse.de>
References: <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <20040508201259.GA6383@in.ibm.com> <20041006125824.GE2004@in.ibm.com> <20040511132205.4b55292a.akpm@osdl.org> <20040514103322.GA6474@in.ibm.com> <20040514035039.347871e8.pj@sgi.com> <20040514110427.GG17326@suse.de> <20040514041433.1b38b120.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514041433.1b38b120.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14 2004, Paul Jackson wrote:
> > so I guess you do.
> 
> Sorry - I'm being thick.
> 
> Is the new hashing good or bad?
> 
> (Usually, performance is thought of as something 'good', so when you say
> it is 'brought down', that sounds 'bad', but since it's ms/iteration,
> I'm guessing that you mean to say that the ms/iteration is lower, which
> would I guess improves performance, so I'm guessing that bringing
> performance down is 'good' in this case, which is not idiomatic to the
> particular version of English I happen to speak ...  So please favor
> this poor old brain of mine and state outright whether the new hash is
> good or bad.  Does the new hash makes performance better or worse?)

:-)

I can only say the way I read the numbers, the new hashing scores higher
ms/iteration which is a bad thing. So when it is stated that
'performance is brought down' I completely agree that it describes the
situation, performance is worse than before.

First table shows 2.6.6 (with old hash) doing better than 2.6.6-BK with
new hash. It then shows 2.6.6-Bk with old hash doing worse than 2.6.6
still, so it's not just the hash that has slowed things down.
2.6.6-new_hash does worse than 2.6.6-stock.

-- 
Jens Axboe

