Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbTCJGQc>; Mon, 10 Mar 2003 01:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261349AbTCJGQc>; Mon, 10 Mar 2003 01:16:32 -0500
Received: from ptil-4-146-ban.primus-india.net ([203.196.146.4]:51587 "EHLO
	proxy-blr.Foo.COM") by vger.kernel.org with ESMTP
	id <S261345AbTCJGQb>; Mon, 10 Mar 2003 01:16:31 -0500
Date: Mon, 10 Mar 2003 11:50:59 +0530
X-Envelope-From: anand@rttsindia.com
From: Anand Gurumurthy <anand@rttsindia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Problem with mmap( ) in linux ppc!
Message-Id: <20030310115059.2862dfb1.anand@rttsindia.com>
Organization: Real time tech solutions
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Gateway: --->> pop@GIFT - POP3/SMTP Gateway 5.5 for GIFTmail <<---
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	We have a driver for a communication card which has memory mapped IO.We are using redhat 2.2.14 kernel on intel p3 processor. The driver has an mmap entry point to map device memory into the user space using remap_page_range(). It works fine with intel P3. When we try to use the same driver with ppc linux 2.2.17 kernel, the mmap system call does not map the proper device memory.Is there anything extra  required for using mmap with ppc? Please help me with your suggestions.

Thanks,
Anand Gurumurthy. 

