Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVCZCGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVCZCGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVCZCGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:06:52 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:45924 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261913AbVCZCGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:06:51 -0500
Message-ID: <4244C3B7.4020409@yahoo.com.au>
Date: Sat, 26 Mar 2005 13:06:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, davem@davemloft.net,
       tony.luck@intel.com, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com> <20050325212234.F12715@flint.arm.linux.org.uk>
In-Reply-To: <20050325212234.F12715@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Mar 23, 2005 at 05:10:15PM +0000, Hugh Dickins wrote:
> 
>>Here's the recut of those patches, including David Miller's vital fixes.
>>I'm addressing these to Nick rather than Andrew, because they're perhaps
>>not fit for -mm until more testing done and the x86_64 32-bit vdso issue
>>handled.  I'm unlikely to be responsive until next week, sorry: over to
>>you, Nick - thanks.
> 
> 
> I thought I'd try these out on ARM, but alas they don't apply to
> 2.6.12-rc1. ;(  This means I won't be testing them, sorry.
> 

The reject should be confined to include/asm-ia64, so it will still
work for you.

But I've put a clean rollup of all Hugh's patches here in case you'd
like to try it.

http://www.kerneltrap.org/~npiggin/freepgt-2.6.12-rc1.patch

