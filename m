Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTI2FEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 01:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTI2FEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 01:04:10 -0400
Received: from dyn-ctb-203-221-72-163.webone.com.au ([203.221.72.163]:29700
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S262839AbTI2FEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 01:04:07 -0400
Message-ID: <3F77BCE4.2010601@cyberone.com.au>
Date: Mon, 29 Sep 2003 15:02:28 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] No Swap. Re: [BUG 2.6.90-test5] kernel shits itself with
 48mb ram under moderate load
References: <ArQ0.821.23@gated-at.bofh.it> <ArQ0.821.25@gated-at.bofh.it> <ArQ0.821.21@gated-at.bofh.it> <ArZC.8f1.9@gated-at.bofh.it> <3F75EC3B.4030305@softhome.net> <20030927201347.GM4306@holomorphy.com> <20030927202548.GB31080@k3.hellgate.ch>
In-Reply-To: <20030927202548.GB31080@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Roger Luethi wrote:

>On Sat, 27 Sep 2003 13:13:47 -0700, William Lee Irwin III wrote:
>
>>>   As I see there is not that much edge case testing going around.
>>>
>>It's known what has to be done for it. AFAICT upstream doesn't like
>>the answers and just says "throw hardware at it". I've written it off
>>as a lost cause, though I was at one time interested.
>>
>
>Well, _I_ don't know that. What are the answers? And while we're at it,
>what's the problem, exactly?
>
>

This particular problem was fixed nicely by getting the kernel to enable
swap, so I don't think its that bad of a problem.

Anyway, I think answers involve sizing data structures more effectively
on small memory boxes, more VM smarts in overload situations, and
probably most important for desktop use: light weight and unbloated
user level environment.


