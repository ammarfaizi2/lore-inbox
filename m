Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWDKTuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWDKTuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWDKTuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:50:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40657 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751169AbWDKTuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:50:12 -0400
Message-ID: <443C0855.2040807@vnet.ibm.com>
Date: Tue, 11 Apr 2006 14:49:41 -0500
From: Michael Reed <mreedltp@vnet.ibm.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ltp-announce@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net
Subject: [ANNOUNCE]  The Linux Test project ltp-20060411 Released
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The Linux Test Project test suite <http://www.linuxtestproject.org> has 
been released. The latest version of the testsuite contains 2900+ tests  
for the Linux   
 OS. Our web site also contains other information such as:
  - A Linux test tools matrix
  - Technical papers
  - How To's on Linux testing
  - Code coverage analysis tool.

 Release Highlights:
 
    *Code Cleanups by Jacky Malcles, Jane Lv, Joe Pearson, Nick Pollitt 
and Thomas Gleixner, Joy Latten,
      and Lin Feng Shen

    *Test cases fcntl127 and fcntl128 were fixed by Robert Williamson

    * A fourth scenario file  was added for ltp-aiodio.sh by Jacky Malcles

    * Feature added to Pounder21 that enables the sysrq key at the 
beginning of each pounder run by Darrick Wong, 
  

We encourage the community to post results to ltp-results@lists.sf.net, 
and patches, new tests, or comments/questions to ltp-list@lists.sf.net


See ChangeLog Below

LTP-20061104
-Applied a patch by Jacky Malcles that added a fourth scenario for 
ltp-aiodio.sh
-Fixed ld01 from failing on Assertions 1-7 for bug 22167
-Applied a fix for Lin Feng Shen to eliminate white spaces that caused 
mail02 to fail
-A fix created by Jacky Malcles that eliminates warning messages when 
complied on 64 bit platform for aiodio_sparse.c
-Applied a patch to re-enable writing on arm per by Joe Pearson / Nick 
Pollitt
-Applied three patches by Joy Latten to the security test suite
-Applied patches from Robert Williamson to fix fcntl127. This test
  should now  be positive test versus negative...based on the properties of
  the open() call in the setup()
-Applied Patch from Robbie Williamson that fixed fcntl128.  This 
testcase was changed the test to expect no errors.  The fcntl() call 
should succeed regardless
-Applied a patch from gettimeofday01 to gettimeofday02 to fix the 
occasional failure
-Applied a fix to madvise02 by Jacky Malcles to eliminate the need for a 
special execution of the testcase for ia_64
-Applied a patch fixes the test 4 of mincore01.c that failed in 32 bit 
on a 64 bit kernel.
-Patches applied to pread02 to fix broken white spacing
-Applied a patch from Jane Lv for pread03.c.  This fixed a missed step 
to initialize the read buffer array.
-Applied Patches submitted by Thomas Gleixner to initialize interval 
values to prevent setitimer01 and 02 from failing
-Applied updates from Darrick Wong for Pounder for Pounder21.  
Documentation was  added to get pounder up and running quickly
-Feature added to Pounder21 that enables the sysrq key at the beginning 
of each pounder run


