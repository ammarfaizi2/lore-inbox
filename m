Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267206AbUBMWVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUBMWVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:21:23 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:47599 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267206AbUBMWVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:21:21 -0500
Date: Fri, 13 Feb 2004 14:18:54 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: Sean Neakums <sneakums@zork.net>, Nagy Tibor <nagyt@otpbank.hu>,
       xela@slit.de, mochel@osdl.org, bmoyle@mvista.com, orc@pell.chi.il.us,
       linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM
Message-ID: <46620000.1076710734@flay>
In-Reply-To: <20040213160909.A6102@lists.us.dell.com>
References: <402CC114.8080100@dell633.otpefo.com> <6uvfmbktrj.fsf@zork.zork.net> <64200000.1076688313@[10.10.2.4]> <20040213160909.A6102@lists.us.dell.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 13, 2004 at 08:05:14AM -0800, Martin J. Bligh wrote:
>> >> We have two Dell Poweredge servers, an older one (PowerEdge 6300) and a
>> >> newer one (PowerEdge 6400). Both servers have 4GB RAM, but the Linux
>> >> kernel uses about 500MB less memory in the newer machine.
>> > 
>> > I may be talking through my hat, but I think that in this case you
>> > need to select the option for support of 64G highmem.  If I recall,
>> > "4G highmem" refers not to the total amount to the memory, but to the
>> > highest physical address that can be accessed.
>> 
>> That's exactly correct. Whether the gain of 500MB of RAM is worth the
>> overhead of PAE is another question ... but that's how to do it ;-)
> 
> If the chipset and BIOS can't remap the physical RAM out of the
> address space needed by the PCI devices and into PAE space, then PAE
> doesn't buy you anything.  You need chipset support for RAM remapping,
> which doesn't exist on the servers mentioned.

Ah, didn't realise you had a hardware problem as well ;-)

M.

