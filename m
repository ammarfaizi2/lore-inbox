Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317325AbSFGTHU>; Fri, 7 Jun 2002 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSFGTHT>; Fri, 7 Jun 2002 15:07:19 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:31246 "EHLO
	lazy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S317325AbSFGTHS>; Fri, 7 Jun 2002 15:07:18 -0400
Date: Fri, 7 Jun 2002 13:53:27 -0500 (CDT)
From: Manoj Iyer <manjo@austin.ibm.com>
X-X-Sender: <manjo@lazy>
To: kernelmailinglist <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCEMENT] Linux Test Project test suite LTP-2002060 released
Message-ID: <Pine.LNX.4.33.0206071351420.8996-100000@lazy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Linux Test Project test suite LTP-20020607.tgz has been released.
Visit our website ( http://ltp.sourceforge.net )to download the latest
version of the test suite, and, for information on test results on pre
release, release candidate and stable releases of the kernel. There is
also a list of test cases that are expected to fail, please find the list
at http://ltp.sourceforge.net/expected-errors.php

The highlights of this release are:

- White paper titled "Analysis of Linux Test Projects Kernel Code
  Coverage"
  This analysis paper aims at identifying areas in the kernel that are
  currently tested by LTP and also identify areas that require attention.

- LTP's Kernel code coverage web site
  http://ltp.sf.net/coverage/index.html.
  Provides a testcase for each kernel source file mapping.

- LTP is available in i386 binary RPM format for download. Also, the LTP
  source RPM and spec file are available for download to allow binary RPM
  builds.

- Linux Test Tools Table. A comprehensive list of tools and testsuites
  available to test Linux.

- MIPS, s390 and 64-bit x86 updates.


We encourage the community to post results, patches or new tests on
our mailing list and use the CVS bug tracking facility to report problems
that you might encounter with the test suite. More details available at
our web-site.

Change Log
----------
* New Additions
- Tests if gettimeofday02 is monotonous      ( Andi Kleen          )
- Added new tests readv03, setgroups04
  and truncate04                             ( Group Bull          )

* Fixes
----------------
- Bug fixes and ports for MIPS               ( Johannes Stezenbach )
- Fixes BROKs on 64bit x86,ISO-C compliance  ( Andi Kleen          )
- 64 bit bug fixes and remove warnings
  on 64 bit arch                             ( Ihno Krumreich      )
- Clean up warnings on s390                  ( William Jay Huie    )
- Improvements on fstat05 for IA64           ( Group Bull          )
- Testcase ID clean ups, improvements
  to mallocstress                            ( Nathan Straz        )
- Fix warnings and bugs in clisrv
  and mallocstress   i                       ( Dan Kegel           )
- Fixed sendfile601 for IPV6                 ( Robert Williamson   )
- Fixes for shmctl & mprotect03              ( Paul Larson         )
- multicast testcase fixes                   ( Ted Cheslak         )
- Automation: added sar results to ltp_check ( Casey Abell         )
- Automation: added function to ltp_check    ( Li Ge               )


Acknowledgements
----------------
- Airong Zhang for testing this release of the LTP.


Thanks
Manoj Iyer

*******************************************************************************
		The greatest risk is not taking one.
*******************************************************************************

