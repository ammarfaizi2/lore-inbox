Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbTIEQA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTIEQA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:00:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30625 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265410AbTIEQAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:00:53 -0400
Subject: [ANNOUNCE] Linux Test Project September Release Announcement
To: ltp-announce@lists.sourceforge.net, ltp-list@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OF073F028E.26C111AE-ON85256D97.006A2CA2-86256D98.00581204@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Fri, 5 Sep 2003 10:59:54 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 09/05/2003 12:00:11 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The Linux Test Project test suite <http://www.linuxtestproject.org> has
 been released. The latest version of the testsuite contains 2000+ tests
for
 the Linux OS. Our web site also contains other information such as: test
 results, a Linux test tools matrix, an area for keeping up with fixes for
 known blocking problems in the 2.5/2.6 kernel releases, technical papers
 and HowTos on Linux testing, and a code coverage analysis tool.

 Highlights:

 * Updated the test coverage "galaxy map" to include all testcases
   for 32bit Intel and PowerPC architectures.

 * Created a device driver framework tool to allow kernel
   level testing of device driver code.

 * Released first version of the SLES 8 EAL 2+ Certification Test Suite.

 * Made improvements that allow for a quicker overall build and install.

 * Applied more bug fixes, patches, and code cleanups.

 We encourage the community to post results, patches or new tests on our
 mailing list and use the CVS bug tracking facility to report problems that
 you might encounter with the test suite.


 See ChangeLog below.

 -Robbie

 Robert V. Williamson <robbiew@us.ibm.com>
 Linux Test Project
 IBM Linux Technology Center
 Web: http://ltp.sourceforge.net
 IRC: #ltp on freenode.irc.net
 ====================
 "Only two things are infinite, the universe and human stupidity, and I'm
 not sure about the former." -Albert Einstein



 CHANGELOG

- Corrected "-d" option for runalltests.sh      ( David Smith )
- Corrected ade commands tests to allow for     ( Xu Cheng
  cross platform ppc64 execution.                 Robbie Williamson )
- Fixed compile errors for device driver        ( Marty Ridgeway )
  tests seen on 2.5.73 kernels and above.       ( Marty Ridgeway )
- Initial drop of drivers/base code.
- Added Device Simulator Framework.             ( Marty Ridgeway
                                                  David Cruz
                                                  Sean Ruyle )
- Removed the need to include sys/stropts.h     ( Robbie Williamson )
  in the syscall tests.
- Modified acct01 to use tty0 to allow for      ( Paul Larson )
  testing in environments without a controlling
  terminal.
- Modified alarm03 to allow the timer to be     ( George Ansinger
  rounded up to the next second.                  Paul Larson )
- Corrected ifdef settings for PowerPC64 by     ( Robbie Williamson )
  changing all __ppc64__ to __powerpc64__
- Corrected pthread id display in the float_    ( Robbie Williamson )
  tests.
- Updated mc_cmds and tcpdump01 to support      ( Xu Cheng
  multiple interfaces.                            Robbie Williamson )
- Applied patches: #788275, #788323, 788727,    ( David Smith )
  and 788836.
- Updated OpenHPI testsuite.                    ( Kevin Gao )
- Removed the top-LTP tool from being built     ( Robbie Williamson )
  using `make all` or `make install`.
- Removed the open_posix and open_hpi           ( Robbie Williamson )
  testsuites from being built using `make all`
  or `make install`.


