Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268122AbTAJDU7>; Thu, 9 Jan 2003 22:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268124AbTAJDU7>; Thu, 9 Jan 2003 22:20:59 -0500
Received: from holomorphy.com ([66.224.33.161]:17558 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268122AbTAJDU6>;
	Thu, 9 Jan 2003 22:20:58 -0500
Date: Thu, 9 Jan 2003 19:29:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Tinsley <btinsley@emageon.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <20030110032937.GI23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Tinsley <btinsley@emageon.com>, linux-kernel@vger.kernel.org
References: <3E1E3B64.5040803@emageon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E1E3B64.5040803@emageon.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> There is no extant implementation of paged stacks yet.

On Thu, Jan 09, 2003 at 09:17:56PM -0600, Brian Tinsley wrote:
> For the most part, this is probably a boundary condition, right? Anyone 
> that intentionally has 800+ threads in a single application probably 
> needs to reevaluate their design :)

IMHO multiprogramming is as valid a use for memory as any other. Or
even otherwise, it's not something I care to get in design debates
about, it's just how the things are used.

The only trouble is support for what you're doing is unimplemented.


At some point in the past, I wrote:
>> I'm working on a different problem (mem_map on 64GB on 2.5.x). I
>> probably won't have time to implement it in the near future, I
>> probably won't be doing it vs. 2.4.x, and I won't have to if someone
>> else does it first.

On Thu, Jan 09, 2003 at 09:17:56PM -0600, Brian Tinsley wrote:
> Is that a hint to someone in particular?

Only you, if anyone. My intentions and patchwriting efforts on the 64GB
and highmem multiprogramming fronts are long since public, and publicly
stated to be targeted at 2.7. Since there isn't a 2.7 yet, 2.5-CURRENT
must suffice until there is.


Bill
