Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285497AbRLGUQI>; Fri, 7 Dec 2001 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285499AbRLGUP7>; Fri, 7 Dec 2001 15:15:59 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:47011 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S285497AbRLGUPs>;
	Fri, 7 Dec 2001 15:15:48 -0500
Message-Id: <m16CRP4-000OWoC@amadeus.home.nl>
Date: Fri, 7 Dec 2001 20:15:26 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: <whitney@math.berkeley.edu>
Subject: Re: Maximizing brk() space on stock ia32 Linux 2.4.x
cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112071128500.440-100000@mf1.private>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0112071128500.440-100000@mf1.private> you wrote:
> Hello,

> Given the limitation of running under a stock ia32 Linux 2.4.x kernel
> (e.g. TASK_UNMAPPED_BASE = 0x40000000 and __PAGE_OFFSET = 0xC0000000), how
> can one write a program in a way to maximize the address space available
> for brk()?  For example:

Try using the "hoard" preload library for malloc() 
Does wonders...
