Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUIIDcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUIIDcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 23:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUIIDcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 23:32:04 -0400
Received: from delta.ece.northwestern.edu ([129.105.5.125]:7593 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S269301AbUIIDcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 23:32:01 -0400
From: Lei Yang <lya755@ece.northwestern.edu>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Unresovled symbol intalling cloop-1.02
Date: Wed, 8 Sep 2004 22:39:16 -0500
User-Agent: KMail/1.5.4
Cc: lya755@ece.northwestern.edu
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409082239.16157.lya755@ece.northwestern.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I want to get cloop-1.02 work on a Linux-2.4.21 box. I downloaded the source, 
compiled it and everthing seems OK. But when I tried "insmod ./cloop.o", 
there would be unresolved symbols. Could anyone provide expertise on this? I 
did have got cloop work on another Linux 2.6 box, rewriting the Makefile 
myself with kbuild. I thought the original Makefile provided by author should 
just work for 2.4, but I am out of luck:(

./cloop.o: unresolved symbol fput_R041e9ef0
./cloop.o: unresolved symbol irq_stat_R62a76ef0
./cloop.o: unresolved symbol create_bounce_R94ac00b1
./cloop.o: unresolved symbol blk_dev_R78f5967e
./cloop.o: unresolved symbol filp_close_R253c57bb
./cloop.o: unresolved symbol mem_map_Ra2dbbaa3
./cloop.o: unresolved symbol kmap_high_Rc804a874
./cloop.o: unresolved symbol blk_queue_make_request_R12d995a1
./cloop.o: unresolved symbol fget_R46e88355
./cloop.o: unresolved symbol highmem_start_page_R259972b3
./cloop.o: unresolved symbol register_disk_R6cbd4195
./cloop.o: unresolved symbol register_blkdev_Re7b627eb
./cloop.o: unresolved symbol __do_generic_file_read_R95bf9295
./cloop.o: unresolved symbol filp_open_Rec737d70

BTW, the maintainers of this project seems to be very very irresponsible. I am 
wondering if anyone still works on that.

TIA!
Lei

