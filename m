Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSG2Owh>; Mon, 29 Jul 2002 10:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317435AbSG2Owh>; Mon, 29 Jul 2002 10:52:37 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:46766 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317404AbSG2Owg>; Mon, 29 Jul 2002 10:52:36 -0400
Date: Mon, 29 Jul 2002 07:54:16 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: William Lee Irwin III <wli@holomorphy.com>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>, riel@conectiva.com.br,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [Lse-tech] Re: [RFC] Scalable statistics counters using kmalloc_percpu
Message-ID: <553334703.1027929256@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0207291225130.20701-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0207291225130.20701-100000@linux-box.realnet.co.sz>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The strangest thing to me is that all the IDs are 0, when they
>> weren't to start with. Something's corrupting memory ... I'd
>> happily blame my own code, but allegedly this has happened without
>> CONFIG_MULTIQUAD too.
> 
> Do you know wether its just the IDs or the whole mp_ioapic[x] struct?

Probably the whole struct, but no ... I don't know for sure.
The debug is easy once we know 1 element that gets corrupted
though.

M.

