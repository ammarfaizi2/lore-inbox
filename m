Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVFTOAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVFTOAb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFTOAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:00:31 -0400
Received: from dvhart.com ([64.146.134.43]:13233 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261254AbVFTOAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:00:13 -0400
Date: Mon, 20 Jun 2005 07:00:07 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 4764] New: On Running LTP test suite testcase nptl	comes out with failures
Message-ID: <175930000.1119276007@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=4764

           Summary: On Running LTP test suite testcase nptl comes out with
                    failures
    Kernel Version: 2.6.12-rc6-mm1
            Status: NEW
          Severity: normal
             Owner: other_other@kernel-bugs.osdl.org
         Submitter: sharyathi@in.ibm.com
                CC: bnpoorni@in.ibm.com,sglass@us.ibm.com


Distribution:
   SLES 9 SP1
-----------------------------
Hardware Environment:
1 way, Pentium IV 2.8GHz, 2G RAM
Network Interface(e1000)
Disk I/O
SCSI storage controller: Adaptec Ultra320
-----------------------------   
Software Environment:
Linux x206h 2.6.12-rc6-mm1-I #3 SMP Sat Jun 25 13:27:57 IST 2005 i686 i686 i386
GNU/Linux
-----------------------------
Problem Description:
    While running the test suite, test case nptl01 fails. nptl01 is a testcase
to test the bug in system call pthread_cond_timedwait() of the native posix
library. 
   The test was supposed to verify a condition where the sequence counters were
getting updated without holding the internal condvar lock.
    A FAIL is indicated by test hangin and not completing execution. 
On running the test individually test hung for more than 300 secs.
-----------------------------


