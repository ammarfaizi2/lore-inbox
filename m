Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314646AbSEGPtO>; Tue, 7 May 2002 11:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315878AbSEGPtN>; Tue, 7 May 2002 11:49:13 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:28307 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314646AbSEGPtM>; Tue, 7 May 2002 11:49:12 -0400
Date: Tue, 7 May 2002 10:36:05 -0500 (CDT)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: kernelmailinglist <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] LTP Kernel Test Suite ltp-20020507 released.
Message-ID: <Pine.LNX.4.33.0205071032300.14693-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Linux Test Project test suite LTP-20020507.tgz has been released.
Visit our website ( http://ltp.sourceforge.net )to download the latest
version of the test suite, and, for information on test results on pre
release, release candidate and stable releases of the kernel. There is
also a list of test cases that are expected to fail, please find the list
at http://ltp.sourceforge.net/expected-errors.php

The highlights of this release are:
- The IBM LTC Test team, part of the Linux Test Project, has published a
  paper (PDF format) titled "Linux Technology Center Testing" summarizing
  the results from enterprise testing recently completed.
  http://ltp.sourceforge.net/LTCtestv1.0.pdf
- New LTP tests added, bug fixes for S390 and cleanups to remove compile
  time warnings.
- LTP Automation script updates.
- LTP test suite ltp-20020507.tgz is also available at the OSDL's Linux
  Kernel Scalable Test Platform.(STP). Visit http://www.osdlab.org/stp for
  more information.

We encourage the community to post results, patches or new tests on our
mailing list and use the CVS bug tracking facility to report problems that
you might encounter with the test suite. More details available at our
web-site.

Change Log
----------
* New Additions
  - New syscalls tests, chroot, fchdir, fstat
    pread, pwrite, and reddir.                      ( Bull )
  - New syscalls test.                              ( Ihno Krumreich )

* Fixes
  - Various S390 bug fixes, patches to remove
    complier warnings.                              ( Ihno Krumreich )
  - S390 bug fixes.                                 ( William Jay Huie )
  - LTP Automation script updates.                  ( William Jay Huie )
  - make testcases work without a controlling tty.
    for recv01, recvfrom01 and recvmsg01.           ( Paul Larson )
  - Networking test updates, multiple concurrent
    runs.                                           ( Robert Williamson )
  - test01 patch for wrap around at 2gigs           ( Randall Hron )
  - patches to syscalls test wait402, chdir03       ( Andreas Jaeger )

CVS Bugs closed.
----------------
  #545739 fcntl17 failing getting unexep. sig13     ( Paul Larson )

Acknowledgements
----------------
- Robbie and Paul for updating CVS with the patches submitted by the
  community.
- Casey Abell for testing this release of the LTP.

Thanks
Manoj Iyer
*******************************************************************************
		The greatest risk is not taking one.
*******************************************************************************

