Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUJATnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUJATnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUJATlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:41:13 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:32206 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S266233AbUJATi1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:38:27 -0400
Date: Fri, 1 Oct 2004 22:38:25 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS Mailing List <reiserfs-list@namesys.com>
Subject: Re: Linux-2.6.9-rc2-bk7 Oops - ReiserFS: warning: vs-500: unknown uniqueness 126844928
Message-ID: <20041001193825.GA6441@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS Mailing List <reiserfs-list@namesys.com>
References: <20040922225859.GA12833@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922225859.GA12833@m.safari.iki.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:58:59AM +0300, Sami Farin wrote:
> I got no replies for messages <20040713110437.GA4571@m.safari.iki.fi>
> and <20040714214146.GA23531@m.safari.iki.fi> to LKML,
> so I try again with latest releases.  Now using 2.6.9-rc2-bk7, and I

Now I compiled kernel with gcc-2.95.3 and:
 22:37:12 up 7 days, 22:34,  2 users,  load average: 0.40, 0.41, 0.43

So, gcc 3.4 and kernel 2.6 do not like each others.
Finding the actual bug (in kernel or compiler) left as an exercise
for some brave hacker.

I know what Documentation/Changes says about GCC versions.
It's just that I am stubborn and I hoped 3.4.x would just work,
since 3.0, 3.1, 3.2 and 3.3 series have produced perfectly working
2.4.x kernels (and 3.4.x has produced perfectly working non-kernel
stuffs).

-- 
Recursive die() failure while reading ~/.signature.

