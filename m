Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVAETRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVAETRI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVAETRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:17:08 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:61580 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262565AbVAETQn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:16:43 -0500
Message-ID: <41DC3D17.8000300@tmr.com>
Date: Wed, 05 Jan 2005 14:16:39 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
CC: Felipe Alfaro Solana <lkml@mac.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Adrian Bunk <bunk@stusta.de>, Willy Tarreau <willy@w.ods.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@debian.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       Rik van Riel <riel@redhat.com>
Subject: Re: starting with 2.7
References: <9F909072-5E3A-11D9-A816-000D9352858E@mac.com><9F909072-5E3A-11D9-A816-000D9352858E@mac.com> <41DBEC44.9080104@hist.no>
In-Reply-To: <41DBEC44.9080104@hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Felipe Alfaro Solana wrote:
> 
>>
>>  I don't pretend that kernel interfaces stay written in stone, for 
>> ages. What I would like is that, at least, those interfaces were 
>> stable enough, let's say for a few months for a stable kernel series, 
>> so I don't have to keep bothering my propietary VMWare vendor to fix 
>> the problems for me, since the new kernel interface broke VMWare. 
>> Yeah, I know I could decide not to upgrade kernels in last instance, 
>> but that's not always possible.
> 
> 
> You should definitely bother your proprietary vendor all the time, they 
> will then
> see more clearly that they have to act fast _if_ they want to stay 
> proprietary.
> 
>>
>> If kernel interfaces need to be changed for whatever reason, change 
>> them in 2.7, -mm, -ac or whatever tree first, and let the community 
>> know beforehand what those changes will be, and be prepared to adapt. 
>> Meanwhile, try to leave 2.6 as stable as possible.
> 
> 
> Do you follow -mm, -ac, and friends closely?  Most changes do happen in 
> -mm first.
> So you have time, all the way up to the next release.  Use that time to 
> bug your
> vendor about the imminent change.  There seems to be weeks between releases
> now, plenty of time for a vendor to stay up-to-date.

What "plenty of time?" There are changes between the last -bk and the 
next release in some cases, significant change within days of release. I 
can't imagine a vendor chasing -mm between releases, and I bet even 
Andrew couldn't say exactly what will or won't go into a release. He has 
goals, but the patches he gets may not be stable enough to include; he 
wants stability, but things may NEED to be changed in the case of a 
major bug or security issue.

Some changes, like 4k stacks, can be seen coming, and changes for them 
don't prevent things from working the old way. Some have to be one thing 
or the other at the level of drivers and vmware, so they may not be 
available the instant a new release hits the spool.

At least things like vmware *will* be fixed, I expect to run 2.4 on some 
machines indefinitely because the proprietary drivers stop there and I 
can't justify replacing the whole system just to get 2.6.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
