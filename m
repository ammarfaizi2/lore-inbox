Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSDHRCS>; Mon, 8 Apr 2002 13:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313704AbSDHRCR>; Mon, 8 Apr 2002 13:02:17 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:14556 "EHLO lazy")
	by vger.kernel.org with ESMTP id <S313698AbSDHRCP>;
	Mon, 8 Apr 2002 13:02:15 -0400
Date: Mon, 8 Apr 2002 10:35:15 -0500 (CDT)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: kernelmailinglist <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>, ltp <ltp-list@lists.sourceforge.net>
Subject: [ANNOUNCE] Linux Test Project (LTP)  - April 2002 Release.
Message-ID: <Pine.LNX.4.33.0204081029440.6167-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Linux Test Project test suite LTP-20020408.tgz has been released.
We are also announcing our improved, user friendly website
http://ltp.sourceforge.net. Thanks to Lisa Sarabia, Jennifer Jobst for
website design and implementation and Shadi Alagheband for the website
logo. Visit our website to download the latest version of the test suite,
and, for information on test results on pre release, release candidate
and stable releases of the kernel. There is also a list of test cases that are
expected to fail, please find the list at
http://ltp.sourceforge.net/expected-errors.php

The highlights of this release are:
- LTP Automation scripts that are intended to completely automate the
updating, running, and reporting of an LTP test run.  The scripts and
related documentation can be found under ltp/tools/ in the tar-zip file.
- IPV6 port and new features added to NetPIPE, an opensource protocol
independent network performance tool.
- More patches from Andi, Andreas and Ihno that fix test case related
problems on 64 bit platform, and removes compile time warning messages.

We encourage the community to post results, patches or new tests on our
mailing list and use the CVS bug tracking facility to report problems that
you might encounter with the test suite.


Change Log
~~~~~~~~~~
* New Additions
  - Scripts to automate LTP test suite execution.   ( William Jay Huie )
  - IPV6 port of NetPIPE, network stress tool.      ( Robert Williamson )

* Fixes
  - Numerous 64-bit updates, remove warnings
    and errors.                                     ( Andi Kleen )
  - 64-bit patches to memory and IPC tests.         ( Ihno Krumreich )
  - 64-bit IA64 port related patches.               ( Jacky Malcles )
  - patches to remove warnings and bugs.            ( Andreas Jaeger )
  - mmstress bug: deletes /dev/zero.                ( Sachin Vyas )
  - sem02: make test remove semids it created.      ( Robert Williamson )
  - Report missing groups and users in IDcheck.sh   ( Robert Williamson )
  - expected error modified in mprotect and
    msync tests.                                    ( Paul Larson )
  - make testcases work without a controlling tty.  ( Paul Larson )

CVS Bugs closed.
~~~~~~~~~~~~~~~~
 #536483 sem02 does not clean up /tmp directory   (Robert Willamson

--
Manoj Iyer

*******************************************************************************
		The greatest risk is not taking one.
*******************************************************************************

