Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbTCZPMi>; Wed, 26 Mar 2003 10:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbTCZPMb>; Wed, 26 Mar 2003 10:12:31 -0500
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:11504 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261720AbTCZPI4> convert rfc822-to-8bit; Wed, 26 Mar 2003 10:08:56 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 update.
Date: Wed, 26 Mar 2003 16:16:22 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200303261604.36119.schwidefsky@de.ibm.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
the s390 patch set has grown again. This time there are 9 patches against
the bitkeeper tree of today 2003/03/26. 

Short descriptions:
1) s390/s390x architecture changes and bug fixes., including the pte_file
   definitions for the nonlinear mapping support. 
2) Add support for system call numbers > 255.
3) Remove s390 make rule for the kernel listing. Add code to generate the
   kerntypes file for post mortem dump analysis with lcrash.
4) Common i/o layer changes.
5) Bug fixes for the ctc, lcs and iucv network drivers.
6) Make uni-processor kernels compile & work again.
7) Bug fixes for the dasd driver. 
8) Improvements on dasd locking and reference counting.
9) Coding style adaptions for the dasd driver. This patch is big but it
   doesn't do much. I removed outdated comments and most of the structure
   typedefs. No real code change in this one.

blue skies,
  Martin.

