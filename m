Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310553AbSCPT6B>; Sat, 16 Mar 2002 14:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310547AbSCPT5v>; Sat, 16 Mar 2002 14:57:51 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:50699 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S310553AbSCPT5e>;
	Sat, 16 Mar 2002 14:57:34 -0500
Date: Sat, 16 Mar 2002 12:57:11 -0700
From: yodaiken@fsmlabs.com
To: Andi Kleen <ak@suse.de>
Cc: yodaiken@fsmlabs.com, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316125711.B20436@hq.fsmlabs.com>
In-Reply-To: <20020316113536.A19495@hq.fsmlabs.com.suse.lists.linux.kernel> <Pine.LNX.4.33.0203161037160.31913-100000@penguin.transmeta.com.suse.lists.linux.kernel> <20020316115726.B19495@hq.fsmlabs.com.suse.lists.linux.kernel> <p73g0301f79.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <p73g0301f79.fsf@oldwotan.suse.de>; from ak@suse.de on Sat, Mar 16, 2002 at 08:32:26PM +0100
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 08:32:26PM +0100, Andi Kleen wrote:
> x86-64 aka AMD Hammer does hardware (or more likely microcode) search of 
> page tables.
> It has a 4 level page table with 4K pages. Generic Linux MM code only sees
> the first slot in 4th level page limit user space to 512GB with 3 levels. 

What about 2M pages?

> Direct mappings and kernel mappings are handled specially by architecture 
> specific code outside that first slot.
> 
> The CPU itself has I/D TLBs split into L1 and L2.

There was something in some AMD doc about preventing tlbflush on process
switch - through a context like thing perhaps? Any idea?


> 
> -Andi

-- 
---------------------------------------------------------
Victor Yodaiken 
Finite State Machine Labs: The RTLinux Company.
 www.fsmlabs.com  www.rtlinux.com

