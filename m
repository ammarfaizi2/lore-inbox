Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269970AbTGKODw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269977AbTGKODv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:03:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:1931 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S269970AbTGKODu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:03:50 -0400
Date: Fri, 11 Jul 2003 07:18:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 901] New: sleeping function called from illegal context at include/linux/rwsem.h:43
Message-ID: <115950000.1057933100@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=901

           Summary: sleeping function called from illegal context at
                    include/linux/rwsem.h:43
    Kernel Version: 2.5.75
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: szazol@e98.hu


Distribution:

  Debian Woody

Hardware Environment:

  IBM Thinkpad T21 Pentium III (Coppermine)

Software Environment:

  Kernel 2.5.75 compiled with gcc 2.95.4
  XFree86 Version 4.2.1.1

Problem Description:

Jul 11 12:05:23 kernel: Debug: sleeping function called from illegal context at
include/linux/rwsem.h:43
Jul 11 12:05:23 kernel: Call Trace: [__might_sleep+78/84] 
[do_page_fault+106/1024]  [do_page_fault+0/1024]  [shmem_nopage+52/96] 
[pte_chain_alloc+25/80]  [do_no_page+554/568]  [sys_vm86old+283/300] 
[error_code+45/56]  [syscall_call+7/11] 


Steps to reproduce:

  Start X or exit from X


