Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRHFGel>; Mon, 6 Aug 2001 02:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRHFGeb>; Mon, 6 Aug 2001 02:34:31 -0400
Received: from [202.54.26.202] ([202.54.26.202]:3291 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S266970AbRHFGeS>;
	Mon, 6 Aug 2001 02:34:18 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256AA0.00244DC4.00@sandesh.hss.hns.com>
Date: Mon, 6 Aug 2001 11:59:28 +0530
Subject: merge_segment() missing in do_mmap_pgoff in 2.4
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I was just going through do_mmap_pgoff()  in mmap.c. In 2.2 kernels after
inserting the vma in doubly linked list we use to call merge_segments to check
the possibility of merging it with other peer segments.
This thing is missing in 2.4. Is this left out intentionally ?? and why ??

--
Amol


