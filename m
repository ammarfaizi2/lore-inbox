Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVKAUBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVKAUBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVKAUBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:01:00 -0500
Received: from fmr21.intel.com ([143.183.121.13]:4563 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751287AbVKAUA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:00:59 -0500
Date: Tue, 1 Nov 2005 12:00:06 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, linux@brodo.de,
       venkatesh.pallipadi@intel.com
Subject: Re: 2.6.14-git3: scheduling while atomic from cpufreq on Athlon64
Message-ID: <20051101120006.A31722@unix-os.sc.intel.com>
References: <200510311606.36615.rjw@sisk.pl> <200511012007.19762.rjw@sisk.pl> <20051101111417.A31379@unix-os.sc.intel.com> <200511012044.11548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200511012044.11548.rjw@sisk.pl>; from rjw@sisk.pl on Tue, Nov 01, 2005 at 08:44:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 08:44:10PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, 1 of November 2005 20:14, Ashok Raj wrote:
> > Thanks Rafael,
> > 
> > could you try this patch instead? I hate to keep these state variables 
> > and thats why i went with the preempt approach, too bad it seems it wont
> > work for more than just the case you mentioned.
> > 
> > seems ugly, but i dont find a better looking cure...
> 
> It fixes my problem.
> 

Thanks,

Andrew: please consider for -mm

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
