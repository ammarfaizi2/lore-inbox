Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVCINlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVCINlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 08:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVCINlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 08:41:23 -0500
Received: from [220.225.34.66] ([220.225.34.66]:29325 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S261628AbVCINlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 08:41:19 -0500
Subject: Questions relating page descriptor
From: Xeon Cathrine <xeon_kat@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1110375700.3948.19.camel@alok.intranet.calsoftinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 19:11:40 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have some questions regarding the page descriptors  in the linux kernel with
discontig memory support. 

According to my understanding memory for page descriptors is allocated from
the
bootmem allocator and that for pg_dat_t structure comes from the
node_remap_start addr. 

So the first question is, does the memory used by bootmem allocator & this
pg_dat_t also have page descriptors. 
In short if i walk all the pfn's in each pg_dat_t will i ever come across the
memory used by page_descriptors and pg_dat_t.

Thanks for giving your attention. 

Regards,
Xeon

