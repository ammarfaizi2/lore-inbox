Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSHHRbi>; Thu, 8 Aug 2002 13:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317686AbSHHRbi>; Thu, 8 Aug 2002 13:31:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2038 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317674AbSHHRbh>;
	Thu, 8 Aug 2002 13:31:37 -0400
Subject: ANNOUNCE: August Linux Test Project Announcement
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF42DAB8DA.8F2270B7-ON87256C0F.00606321@boulder.ibm.com>
From: "Airong Zhang" <zhanga@us.ibm.com>
Date: Thu, 8 Aug 2002 12:34:43 -0500
X-MIMETrack: Serialize by Router on D03NM127/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/08/2002 11:34:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite LTP-20020806.tgz has been released.
Visit our website ( http://ltp.sourceforge.net ) to download the latest
version of the test suite, and for information on test results on
pre-release, release candidate and stable releases of the kernel. There is
also a list of test cases that are expected to fail, please find the list
at http://ltp.sourceforge.net/expected-errors.php.

Highlights
----------
- LTP's Kernel Code Coverage website for 2.5.X kernel is live
  http://ltp.sf.net/coverage/coverage-2.5.26/index.html
- Kernel code coverage tools are available on CVS under module utils
- Automated test frame work to extract, build and install various Linux
  tests are available on CVS under module utils
- Database stress tool 'dbgrinder' is available on cvs under
ltp/utils/database

We encourage the community to post results, patches or new tests on
our mailing list and use the CVS bug tracking facility to report problems
that you might encounter with the test suite. More details are available at
our web-site.

Change Log
----------

* New Additions
---------------
- Added new test-cases for link07,fcntl22,link06        ( Group Bull
)
- Added Linux kernel scheduler latency tester           ( Davide Libenzi
)
- Database test tool 'dbgrinder'                        ( James Kenefick
)

* Fixes
-------
- Several fixes for 64-bit                              ( Gerhard Tonn
)
- fstat05,llseek fixes for MIPS                         ( Carsten Langgaard
)
- Fixed check in getgroups03 that was causing
  failures if 'nobody' isn't in any secondary groups    ( Paul Larson
)
- Fix sendfile02 to work with the new 2.5 kernels which
  no longer allow it to fall back on write              ( Paul Larson
)
- Changed the hard-coded ip address to 127.0.0.1 in
  recvfrom01-sctp-udp-ipv6                              ( Robbie Williamson
)
- Added instance and time command line options in
  runalltests.sh                                        ( Jeff Martin
)
- Fixed the algorithm description for fork07,fork12
  Reduced the output of fork07 to a finite amount       ( Nathan Straz
)
- Added fork12 to runtest/crashme.                      ( Nathan Straz
)
- Added option for interface selection in tcpdump01     ( Robbie Williamson
)

CVS Bugs closed
---------------
#591695 getgroups03 fails on some distros
#591698 sendfile02 fails with 2.5 kernels

Acknowledgements
----------------
- Manoj Iyer,James Kenefick and Peter Oberparleiter for delivering the
coverage
  analysis toolset.


Airong Zhang
Beta Testing
IBM Linux Technology Center
zhanga@us.ibm.com
908-1D-007, 838-1763



