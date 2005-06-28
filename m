Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVF1B07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVF1B07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVF1B07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:26:59 -0400
Received: from holomorphy.com ([66.93.40.71]:19598 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261586AbVF1B0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:26:53 -0400
Date: Mon, 27 Jun 2005 18:26:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
Message-ID: <20050628012646.GP3334@holomorphy.com>
References: <42BF9CD1.2030102@yahoo.com.au> <20050627004624.53f0415e.akpm@osdl.org> <42BFB287.5060104@yahoo.com.au> <20050627131710.GC13945@kvack.org> <42C09AB3.7030907@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C09AB3.7030907@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
>> Shared memory overhead doesn't show up on any of the database benchmarks 
>> I've seen, as they tend to use huge pages that are locked in memory, and 
>> thus don't tend to access the page cache at all after ramp up.

On Tue, Jun 28, 2005 at 10:32:51AM +1000, Nick Piggin wrote:
> To be quite honest I don't have any real workloads here that stress
> it, however I was told that it is a problem for oracle database. If
> there is anyone else who has problems then I'd be interested to hear
> them as well.

It's vlm-specific.


-- wli
