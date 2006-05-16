Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWEPClm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWEPClm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWEPClm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:41:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:63210 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751075AbWEPCll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:41:41 -0400
Message-ID: <44693BDF.3020909@vnet.ibm.com>
Date: Mon, 15 May 2006 21:41:35 -0500
From: Michael Reed <mreedltp@vnet.ibm.com>
Reply-To: mreedltp@vnet.ibm.com
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: ltp-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ltp-list@lists.sourceforge.net
Subject: [ANNOUNCE]  The Linux Test project ltp-20060515 Released
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test Project test suite <http://www.linuxtestproject.org> has 
been released. The latest version of the testsuite contains 2900+ tests  
for the Linux   OS. Our web site also contains other information such as:
 - A Linux test tools matrix
 - Technical papers
 - How To's on Linux testing
 - Code coverage analysis tool.

Release Highlights:

* Code Cleanups by Jacky Malcles, Jane Lv, Bibo Maoand Thomas Gleixner
* The date of the version of LTP is now printed in log files.

We encourage the community to post results to ltp-results@lists.sf.net, 
and patches, new tests, or comments/questions to ltp-list@lists.sf.net

See ChangeLog Below

LTP-20060515
-Added a -e option to print out the date of the ltp release.  Also
 the date of the version of LTP will be printed in log files.    
-A patch for parse_opts.c was removed because it caused several test 
cases to fail
-Added a patch from Jacky Malcles to correct typos in ltp-aiodio.sh
-Added a patch from Jacky Malcles to fix aiodio_append.c
-Added a patch from Bibo Mao that fixes setrlimit03
-Added a patch that fixes file_test.sh. 
-Added a patch that fixes gethostid01
- Patches submitted by Thomas Gleixner to initialize interval values in 
setitimer03
-A problem that was  reported by Jane Lv, mmap() returns an unsigned 
value (MAP_FAILED) upon error, so checking with <= 0 will not work was 
fixed in   link04.c, lstate02.c mkdir01, mkdir03, mknod06, open08 
read02.c rmdir06.c stat03.c statfs03 symlink03.c sysfs06.c truncate03.c 
uplink07.c write03.c and writev01.c - writev05.c

 

