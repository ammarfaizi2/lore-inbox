Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbRE3JLL>; Wed, 30 May 2001 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262660AbRE3JLB>; Wed, 30 May 2001 05:11:01 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:34311 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S262659AbRE3JK5>; Wed, 30 May 2001 05:10:57 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A5C.002E4CF0.00@d73mta01.au.ibm.com>
Date: Wed, 30 May 2001 13:31:46 +0530
Subject: pte_page
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the 'pgt_offset', 'pmd_offset', 'pte_offset' and 'pte_page' inside a
module to get the physical address of a user space virtual address. The
physical address returned by 'pte_page' is not page aligned whereas the
virtual address was page aligned. Can somebody tell me the reason?

Also, can i use these functions to get the physical address of a kernel
virtual address using init_mm?

regards,
Daljeet.


