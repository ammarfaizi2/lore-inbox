Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUBHBZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUBHBZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:25:35 -0500
Received: from dp.samba.org ([66.70.73.150]:21389 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261931AbUBHBZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:25:13 -0500
Date: Sun, 8 Feb 2004 12:22:43 +1100
From: Anton Blanchard <anton@samba.org>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Nick Piggin <piggin@cyberone.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040208012243.GW19011@krispykreme>
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208011221.GV19011@krispykreme>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My current tree has your patch and Martins patch. So far its looking
> good.

Actually now it refuses to let me out of 1 cpu (2 threads). Theres 5
things in the runqueue but Im only using 1 cpu.

Anton

cpu    user  system    idle             cpu    user  system    idle
cpu0     98       2       0             cpu1     98       2       0
cpu2      0       0     100             cpu3      0       0     100
cpu4      0       0     100             cpu5      0       0     100
cpu6      0       0     100             cpu7      0       0     100
cpu8      0       0     100             cpu9      0       0     100
cpu10     0       0     100             cpu11     0       0     100
cpu12     0       0     100             cpu13     0       0     100
cpu14     0       0     100             cpu15     0       0     100
