Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSKHNop>; Fri, 8 Nov 2002 08:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSKHNop>; Fri, 8 Nov 2002 08:44:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53170 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261973AbSKHNoo>;
	Fri, 8 Nov 2002 08:44:44 -0500
Subject: [ANNOUNCE] LTP-20021107
From: Jeff Martin <ffej@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Nov 2002 07:50:07 -0600
Message-Id: <1036763407.12885.4.camel@bfe.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20021107.tgz has been released.
Visit our website (http://ltp.sourceforge.net) to download the latest
version of the testsuite, and for information on test results on
pre-releases, release candidates & stable releases of the kernel. There
is also a list of test cases that are expected to fail, please find
the list at (http://ltp.sourceforge.net/expected-errors.php)

We encourage the community to post results, patches, or new tests on our
mailing list, and to use the CVS bug tracking facility to report
problems that you might encounter. More details available at our
web-site.


Change Log
------------
- Added "setdomainname01", "setdomainname02",     ( Saji Kumar )
  and "setdomainname03" to "syscalls" runtest file
- Added "sethostname01", "sethostname02",         ( Suresh Babu )
  and "sethostname03" to "syscalls" runtest file
- Fixed bug introduced in "fsstress.c"     ( Andi Kleen, Andrew Morton )
- Fix "chdir03.c" to remove unintentional \n in   ( Paul Larson )
  the directory name
- Added code to remove the tmp test dir           ( Robbie Williamson )
  in "fcntl11.c"
- fix for "shmctl01.c" to get rid of the shmdt    ( Manfred Spraul )
  failures in "shmctl01"
- Fix for "readdir01" slightly incorrect errno    ( Paul Larson )
  handling
- Back out "readv01", "readv02" changes to        ( Paul Larson )
  expect EINVAL when count==0.  Kernel is going
  to keep the old behaviour.
- Fix for "waitpid02". uses undefined div by      ( Paul Larson )
  0 behaviour
- Revert "writev01.c" back to not expect EINVAL   ( Paul Larson )
  when count==0
- Fix for "mc_commo". Changed a 'ps -ef' command  ( Robbie Williamson )
  to 'ps -ewf' to ensure that a grep finds the
  info it needs.
- Fix in mc_member. Corrected typo causing false  ( Robbie Williamson )
  pass. Found by Li Ge 
- Fix in "tcpdump01". Removed erroneous INTERFACE ( Robbie Williamson )
  declaration.
- Fix tools/ltprun to use the new runalltests     ( William Jay Huie )
  semantics


