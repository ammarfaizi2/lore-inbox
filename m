Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbVI0Vpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbVI0Vpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVI0Vpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:45:47 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:7311 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965164AbVI0Vp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:45:26 -0400
Subject: Re: [ckrm-tech] Re: [PATCH 1/3] CPUMETER: add cpumeter framework
	to the CPUSETS
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, KUROSAWA Takahiro <kurosawa@valinux.co.jp>,
       taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, ckrm-tech@lists.sourceforge.net
In-Reply-To: <1127812937.5174.6.camel@npiggin-nld.site>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	 <20050909.203849.33293224.taka@valinux.co.jp>
	 <20050909063131.64dc8155.pj@sgi.com>
	 <20050910.161145.74742186.taka@valinux.co.jp>
	 <20050910015209.4f581b8a.pj@sgi.com>
	 <20050926093432.9975870043@sv1.valinux.co.jp>
	 <20050927013751.47cbac8b.pj@sgi.com>
	 <1127812937.5174.6.camel@npiggin-nld.site>
Content-Type: text/plain
Organization: IBM
Date: Tue, 27 Sep 2005 14:45:16 -0700
Message-Id: <1127857516.4861.37.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 19:22 +1000, Nick Piggin wrote:
> 
> Last time I looked at the CKRM cpu controller code I found
> it was quite horrible, with a great deal of duplication and
> very intrusive large and complex.

I admit it :)... and that was the reason why we did not post that to
lkml.

> It could have come a long way since then, but this code looks

Since we were not planning to use it there isn't much change in the
code :(
> much neater than the code I reviewed.
> 
> I guess the question of the resource controller stuff is going
> to come up again sooner or later. I would hope to have just a
> single CPU resource controller (presumably based on cpusets),
> the simpler the better ;)

We were planning to start on a simplified CPU controller that can
provide the functionalities CKRM is expected to provide. 

As I stated in an earlier email cpusubsets looks promising for CKRM, but
we are not able to spend more time on it as of now as the team is very
busy trimming down CKRM.
> 
> Nick
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


