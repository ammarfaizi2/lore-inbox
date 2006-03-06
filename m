Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWCFTbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWCFTbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbWCFTbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:31:14 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:13548 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751488AbWCFTbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:31:12 -0500
Subject: [ANNOUNCE] March release of LTP
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OFE83C07B7.7E7B3A4C-ON85257129.006B0D96-86257129.006B3228@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Mon, 6 Mar 2006 13:30:53 -0600
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.4FP3 HF3|February 22, 2006) at
 03/06/2006 14:31:10
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The March release of LTP is available on ltp.sourceforge.net

Changes for March

LTP-20060306
- Applied an update to allow people to automatically declare the CREATE
variable in IDcheck.sh.
- export a bunch of settings by default that since they are harmless
- allow people to store custom settings in config.mk
- move rec_signal/send_signal out of zoolib.h and into pan.c since only
pan.c uses them and more than just pan.c includes zoolib.h
- Fix from Jackie Malcles, no such file or directory error
- make sure clean descends into the templates dir
- cleanup CRLFs from end of lines,
- fix dependency tracking so targets arent rebuilt all the time
- Applied LDFLAG cleanup patch from Mike Frysinger.
- set default Debug level to off
- fix warning: growfiles.c:357: warning: unused variable `opterr'
- use errno.h instead of doing extern int errno
- cut extraneous newlines from test output
- kill off unused strings msg1 and msg2
- cleanup test output by adding a lot more useful debug info
- use proper test output routines rather than homebrewed printf statements
- use proper tst_* functions for output
- fix for defect 21622, insufficient timeout value
- tighten up uClinux disabled messages
- fixes by Jane Lv to disable EFAULT related tests on uClinux
- cleanup debug output that shouldnt be shown at normal runtime
- make the -F option a bit smarter
- remove extraneous output and improve output when we do issue messages
- Jane Lv writes: I have patched flock03.c and sched_setparam05.c to
replace fork() by vfork() on uClinux.
- calculate TST_TOTAL based upon the number of elements in the test array
instead of hardcoding the value
- use TFAIL instead of TINFO to report test failures in getcwd02
- fix test on x86_64 and make error output a bit more helpful in
gettimeofday
- New Memory mapping testcases.
- Jane Lv writes: use FORK_OR_VFORK() instead of fork() so this stuff works
on uClinux
- need to define _GNU_SOURCE before including features.h or sigset
prototype is missed
- patched flock03.c and sched_setparam05.c to replace fork() by vfork() on
uClinux.
- use syscall() instead of _syscall2() to improve portability
- define INVALID_ADDRESS to get rid of warnings on 32bit hosts and make it
more sane in general
- Fix for defect 21134, look for syslog-ng instead of syslogd on some
systems.
- if a test failed as a non-root user and the reason was EPERM, then mark
the test as PASS, not FAIL
  (security-minded kernels often restrict kernel buffer access for non-root
users)
- fix test on 64bit hosts in syslog12

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 902/6B021
Austin, TX.

