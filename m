Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262984AbVDBD7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbVDBD7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbVDBD7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:59:24 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:22655 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262984AbVDBD7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:59:21 -0500
Message-ID: <424E1895.2070409@yahoo.com.au>
Date: Sat, 02 Apr 2005 13:59:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: remove unnecessary sched domains
References: <20050401162039.A4320@unix-os.sc.intel.com> <424DFE5F.2040804@yahoo.com.au> <20050401193121.B5598@unix-os.sc.intel.com>
In-Reply-To: <20050401193121.B5598@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Apr 02, 2005 at 12:07:27PM +1000, Nick Piggin wrote:
> 
>>I was thinking we could fix that by running balance on fork/exec multiple
>>times from top to bottom level domains. I'll have to measure the cost of
>>doing that, because it may be worthwhile.
> 
> 
> Agreed.
> 
> BTW, why are we setting SD_BALANCE_FORK flag for NUMA domain on i386, ia64.
> This should be set only on x86_64 and that too not for Intel systems.
> 

Mainly to see whether anyone reports regressions, and to exercise
the code a bit.

-- 
SUSE Labs, Novell Inc.

