Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267047AbUBMQGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267051AbUBMQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:06:41 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:18594 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S267047AbUBMQGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:06:39 -0500
Date: Fri, 13 Feb 2004 08:05:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sean Neakums <sneakums@zork.net>, Nagy Tibor <nagyt@otpbank.hu>
cc: xela@slit.de, mochel@osdl.org, bmoyle@mvista.com, orc@pell.chi.il.us,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
Message-ID: <64200000.1076688313@[10.10.2.4]>
In-Reply-To: <6uvfmbktrj.fsf@zork.zork.net>
References: <402CC114.8080100@dell633.otpefo.com> <6uvfmbktrj.fsf@zork.zork.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am sorry, I have found your e-mail address in
>> ./arch/i386/kernel/setup.c. I have the problem below since a year, and
>> there is no solution yet. I guess, the problem is about e820. The
>> problem exists in 2.4.x and also in 2.6.1.
>> 
>> We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a
>> newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux
>> kernel uses about 500MB less memory in the newer machine.
> 
> I may be talking through my hat, but I think that in this case you
> need to select the option for support of 64G highmem.  If I recall,
> "4G highmem" refers not to the total amount to the memory, but to the
> highest physical address that can be accessed.

That's exactly correct. Whether the gain of 500MB of RAM is worth the
overhead of PAE is another question ... but that's how to do it ;-)

M.

