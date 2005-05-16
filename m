Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVEPMmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVEPMmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVEPMmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 08:42:47 -0400
Received: from [80.247.74.3] ([80.247.74.3]:36493 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261578AbVEPMmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 08:42:43 -0400
Message-Id: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 16 May 2005 14:42:35 +0200
To: linux-kernel@vger.kernel.org
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: How to use memory over 4GB
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I've a dual Xeon 3.2GHz HT with 8GB of memory running kernel 2.6.11.
I whould like to know the way how to use all the memory in a single
process, the application is a big simulation which needs big memory chuncks.
I have readed about hugetlbfs, shmfs and tmpfs, but don't understand how I 
can access
the whole memory. Ok! I can create a big file on tmpfs using shm_open() and
than map it by using mmap() or mmap2() but how can I access over 4GB using
standard pointers (if I had to use it)?

So, please send me some url, documents etc and/or piece
of source code that shows how to do it in user space.

Thanks _very much_ in advance,

Roberto Fichera. 

