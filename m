Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVJaQwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVJaQwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 11:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJaQwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 11:52:31 -0500
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:26752 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S932467AbVJaQwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 11:52:30 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Date: Mon, 31 Oct 2005 16:52:28 +0000
User-Agent: KMail/1.8.2
References: <53bh4-4UB-5@gated-at.bofh.it> <53qJ9-1YO-5@gated-at.bofh.it> <E1EWWjk-000583-NS@shinjuku.zaphods.net>
In-Reply-To: <E1EWWjk-000583-NS@shinjuku.zaphods.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510311652.28993.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 10:17, Stefan Schmidt,,, wrote:
> In linux.kernel, you wrote:
> > Unfortunately, the machine does quite a bit of other work apart from
> > BIND, so unless somebody can reproduce this on another machine, it will
> > be a bit difficult.
>
> I saw the same error with 2.6.14-rc5 and filed bug #5505 against it. I

I'm suprised 2.6.14 went out the door without this being resolved. I'm glad I 
spotted this thread in time to avoid upgrading my servers! I guess it was 
reported on the cusp of the release though.

> was also able to reproduce the behaviour using the same kernel and same
> library/compiler versions on another machine using the same set of zones
> and tcpreplay to simulate the query load. Our machine gets around 10
> queries per second at ~40k slave zones. BIND version is 9.3.2v1 which
> runs smoothly on our in-production nameserver with kernel 2.6.13.4 now.
>
> netdev and the usual suspects are aware of the problem.

I guess I'll  follow this on bugzilla.

Andrew Walrond
