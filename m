Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSJHTee>; Tue, 8 Oct 2002 15:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263442AbSJHTdk>; Tue, 8 Oct 2002 15:33:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63449 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261485AbSJHTcA>;
	Tue, 8 Oct 2002 15:32:00 -0400
Subject: [ANNOUNCE] Linux Test Project October Release Available
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFFD6D99D7.513F8BA0-ON85256C4C.006B8A1F@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Tue, 8 Oct 2002 14:37:30 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/08/2002 03:37:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20021008.tgz has been released. Visit
our website (http://ltp.sourceforge.net) to download the latest version of
the testsuite, and for information on test results on pre-releases, release
candidates & stable releases of the kernel. There is also a list of test
cases that are expected to fail, please find the list at (
http://ltp.sourceforge.net/expected-errors.php)

The highlights of this release are:

- Updated the STAX LTP driver. You can now specify client and server
logging paths.  The ability to define how long a single test is allowed run
has been added. Plus, hardware information is now included in the logs for
each client. The HowTo has been updated as well.

- Updated the Database Opensource Test Suite (DOTS) with added
functionality to allow the use of MySQL and PostreSQL databases,
complementing the existing features that allow the use of DB2, Oracle, and
Sybase databases.  Additionally, DOTS is now available as an on-demand test
suite at the Open Source Development Lab's Linux Kernel Scalable Test
Platform. (http://www.osdl.org/stp)

- An additional shared memory control test has been added (shmctl04), that
tests the SHM_INFO command.

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report problems
that you might encounter. More details available at our web-site.


Change Log
------------
- Added "shmctl04" to test the SHM_INFO command  ( Mingming Cao )
- Fix for improper child exit in "execve02"      ( Colin Gibbs )
- Fix for "nanosleep02" to eliminate false       ( Andreas Arcangeli )
  positives
- Fix for "personality01 to undef the personality( Marcus Meissner )
  macro before calling personality()
- Fix for "sendfile02" that adds a waitpid() call( Susanne Wintenberger )
  to guarantee child exit before the test ends
- Fix for /tools/rand_lines.c that eliminates an ( Nathan Straz )
  IA64 compile time warning
- Added "shmctl04" to the "syscalls" runtest file( Paul Larson )
- Removed test 8 from "diotest4". Opening a      ( Paul Larson )
  directory for direct I/O is not allowed.
- Fix for PPC cross compile issues applied to:   ( Paul Larson )
    "mmap01"
    "pth_str01"
    "pth_str03"
    "shmem_test_04"
- Fix for "fcntl01" to allow it to run without   ( Paul Larson )
  predefining the file descriptors
- Fix for "readv02" to check for EINVAL on       ( Paul Larson )
  2.5.35 and above kernels
- Fix for "stime01" to allow the checked time to ( Paul Larson )
  be off +1 second
- Fix for "writev01" to check for EINVAL on      ( Paul Larson )
  2.5.35 and above kernels

Robbie  Williamson <robbiew@us.ibm.com>
Linux Test Project
http://ltp.sourceforge.net


