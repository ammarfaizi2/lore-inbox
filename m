Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUDMHvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 03:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUDMHvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 03:51:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:59297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263138AbUDMHva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 03:51:30 -0400
Date: Tue, 13 Apr 2004 00:51:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: hugh@veritas.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
Message-Id: <20040413005111.71c7716d.akpm@osdl.org>
In-Reply-To: <1130000.1081841981@[10.10.2.4]>
References: <1130000.1081841981@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> UP Athlon 2100+ with 512Mb of RAM. Rebooted clean before each test
> then did "make clean; make vmlinux; make clean". Then I timed a
> "make -j 256 vmlinux" to get some testing under mem pressure. 
> 
> I was trying to test the overhead of objrmap under memory pressure,
> but it seems it's actually distinctly negative overhead - rather pleasing
> really ;-) 
> 
> 2.6.5
> 225.18user 30.05system 6:33.72elapsed 64%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (37590major+2604444minor)pagefaults 0swaps
> 
> 2.6.5-anon_mm
> 224.53user 26.00system 5:29.08elapsed 76%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (29127major+2577211minor)pagefaults 0swaps

A four second reduction in system time caused a one minute reduction in
runtime?  Pull the other one ;)

Average of five runs, please...

