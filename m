Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUEXH7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUEXH7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUEXH7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:59:41 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:2674 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261830AbUEXH7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:59:40 -0400
Message-ID: <40B1AB68.40209@yahoo.com.au>
Date: Mon, 24 May 2004 17:59:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Phy Prabab <phyprabab@yahoo.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
References: <20040524075024.84699.qmail@web90001.mail.scd.yahoo.com>
In-Reply-To: <20040524075024.84699.qmail@web90001.mail.scd.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab wrote:
> NO HT, disabled in bios and did not enable in kernel:
> cat /proc/cpuinfo|grep processor|wc -l
>   2
> grep SMT .config (2.6.7-rc1)
> # CONFIG_SCHED_SMT is not set
> 
> On 2.4.21 I also include "append=noht"
> 

OK good, that makes things simpler.

I'm out of ideas though. The kernel just doesn't seem to be
the problem here. Can you put together a testcase that causes
the problem and that we can download and reproduce it?

Otherwise, try to work out why your userspace processes are
more often idle under the 2.6 kernel.
