Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbTDZPZp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 11:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbTDZPZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 11:25:45 -0400
Received: from franka.aracnet.com ([216.99.193.44]:19621 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261572AbTDZPZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 11:25:44 -0400
Date: Sat, 26 Apr 2003 08:34:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Davidsen <davidsen@tmr.com>, Robert Love <rml@tech9.net>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, bcrl@redhat.com, akpm@digeo.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <16840000.1051371265@[10.10.2.4]>
In-Reply-To: <Pine.LNX.3.96.1030426062917.20200A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030426062917.20200A-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > | The point is that even if bash is fixed it's desirable to address the
>> > | issue in the kernel, other applications may well misbehave as well.
>> > 
>> > So when would this ever end?
>> 
>> Exactly what I was thinking.
>> 
>> The kernel cannot be expected to cater to applications or make
>> concessions (read: hacks) for certain behavior.  If we offer a cleaner,
>> improved interface which offers the performance improvement, we are
>> done.  Applications need to start using it.
>> 
>> Of course, I am not arguing against optimizing the old interfaces or
>> anything of that nature.  I just believe we should not introduce hacks
>> for application behavior.  It is their job to do the right thing.
> 
> I don't care much if the kernel does something to make an application run
> better, that's an application problem. But if an application can do
> something which hurts the performance of the system as a whole, then the
> kernel should protect itself and the rest of the system.
> 
> So I'm not advocating that the kernel cater to bash, just that doing
> legitimate things with bash not have a disproportionate impact on the rest
> of the system.

It's not just bash ... it's most applications.

M.

