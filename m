Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTCDXp0>; Tue, 4 Mar 2003 18:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTCDXp0>; Tue, 4 Mar 2003 18:45:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:41130 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263333AbTCDXp0>;
	Tue, 4 Mar 2003 18:45:26 -0500
Date: Tue, 4 Mar 2003 15:51:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Cc: linux-kernel@vger.kernel.org, kai.bankett@ontika.net, mingo@redhat.com,
       jun.nakajima@intel.com, asit.k.mallick@intel.com,
       sunil.saxena@intel.com
Subject: Re: [PATCH][IO_APIC] 2.5.63bk7 irq_balance improvments / bug-fixes
Message-Id: <20030304155150.33c81675.akpm@digeo.com>
In-Reply-To: <E88224AA79D2744187E7854CA8D9131DA8B7DE@fmsmsx407.fm.intel.com>
References: <E88224AA79D2744187E7854CA8D9131DA8B7DE@fmsmsx407.fm.intel.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 23:55:44.0962 (UTC) FILETIME=[922DCA20:01C2E2A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kamble, Nitin A" <nitin.a.kamble@intel.com> wrote:
>
> Both the solutions will eliminate the bouncing behavior. The current 
> implementation is based on the option 2, with the only difference of 
> lower rate of distribution (5 sec).  The optimal option is workload 
> dependant. With static and heavy interrupt load, the option 2 looks 
> better, while with random interrupt load the option 1 is good enough.

OK, thanks.

Now there has been some discssion as to whether these algorithmic decisions
can be moved out of the kernel altogether.  And with periods of one and five
seconds that does appear to be feasible.

I believe that you have looked at this before and encountered some problem
with it.  Could you please describe what happened there?

