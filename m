Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318328AbSG3QZa>; Tue, 30 Jul 2002 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318340AbSG3QYx>; Tue, 30 Jul 2002 12:24:53 -0400
Received: from holomorphy.com ([66.224.33.161]:39090 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318328AbSG3QYB>;
	Tue, 30 Jul 2002 12:24:01 -0400
Date: Tue, 30 Jul 2002 09:27:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Linux kernel deadlock caused by spinlock bug
Message-ID: <20020730162706.GA25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@suse.de>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	linux-kernel@vger.kernel.org
References: <3FAD1088D4556046AEC48D80B47B478C0101F3AE@usslc-exch-4.slc.unisys.com.suse.lists.linux.kernel> <p73vg6xs5nr.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <p73vg6xs5nr.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 03:32:08PM +0200, Andi Kleen wrote:
> One such way would be a variant of queued locks, like John Stultz's
> http://oss.software.ibm.com/developer/opensource/linux/patches/?patch_id=218
> These are usually needed for fairness even with plain spinlocks on NUMA 
> boxes in any case (so if your box is NUMA then you will need it anyways) 
> They only exist for plain  spinlocks yet, but I guess they could be extended 
> to readlocks. 

I should point out plenty of stock PC hardware gets NUMA effects.
For some reason there's not much documentation and/or publicity about
it, though. I wonder why... (don't answer, I know why and know I'm fscked)


Cheers,
Bill
