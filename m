Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbRF0Vby>; Wed, 27 Jun 2001 17:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265417AbRF0Vbo>; Wed, 27 Jun 2001 17:31:44 -0400
Received: from imladris.infradead.org ([194.205.184.45]:44050 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S265414AbRF0Vbc>;
	Wed, 27 Jun 2001 17:31:32 -0400
Date: Wed, 27 Jun 2001 22:31:22 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Allocating non-contigious memory
In-Reply-To: <E15FKQh-0005ef-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0106272229250.26936-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

 >> What is the Right Way[tm] as of 2.4.6 to allocate 16Mb as 4K
 >> pages and get the pci bus address for each page?  Bonus points
 >> is they're virtually contiguous, but that's not necessary.
 >> IIRC, the old vmalloc-then-walk-the-pagetables trick is
 >> considered out-of-bounds nowadays.

 > If you want it virtually contiguous then copy the code from bttv
 > that out-of-bounds or otherwise is now found in about 8 drivers
 > in the kernel.

Would it be useful to turn that particular code into a subroutine that
is called from each driver, or would that cause other problems?

Best wishes from Riley.

