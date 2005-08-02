Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVHBSVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVHBSVZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVHBSVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:21:25 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48654 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261700AbVHBSVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:21:24 -0400
Message-ID: <42EFBAB2.7090908@tmr.com>
Date: Tue, 02 Aug 2005 14:25:54 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i387 floating-point test program/benchmark
References: <200507291639_MC3-1-A5E6-856D@compuserve.com> <20050729221518.GB20253@redhat.com>
In-Reply-To: <20050729221518.GB20253@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Jul 29, 2005 at 04:36:05PM -0400, Chuck Ebbert wrote:
>  > 			memset(&cpuset, sizeof(cpuset), 0);
> 
> This bug is like a disease, I swear.
> (swapped args)

Among other issues.

Therefore: add_tail(spare_time_Q);


oddball:davidsen> cc -o i387bench -Os i387_bench.c
i387_bench.c:27: parse error before `cpuset'
i387_bench.c:27: warning: data definition has no type or storage class
i387_bench.c:34: unknown field `sa_handler' specified in initializer


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
