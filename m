Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbVJESf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbVJESf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVJESf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:35:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58266 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030314AbVJESf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:35:56 -0400
Subject: [ANNOUNCE] October Release of LTP
To: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net,
       ltp-announce@lists.sourceforge.net
X-Mailer: Lotus Notes Release 6.5.3 September 14, 2004
Message-ID: <OF168A367A.CE87AB05-ON85257091.0065FF5B-86257091.006625CE@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Wed, 5 Oct 2005 13:35:49 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.5.4FP1 HF2|August 30, 2005) at
 10/05/2005 14:35:54
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The October release of LTP is now available:

LTP-20051005
- this patch touchs up the output of ver_linux if gcc, fdformat, or mount
is missing
- New testcases for tpm
- Fix compile error with strsep on some systems.
- Add a missing include file and corrects an fprintf
  format type to eliminate warning messages.  It also performs some minor
  whitespace cleanup.
- patch attached fixes it so writetest is rebuilt whenever writetest.c is
updated
- patch typecasts in writetest - the values given to printf to (long long
int)
- patch initializes some uninitialized variables and adds a
  return statement (non-void function) to eliminate warning messages.
- patch process.c adds a missing include file, function return types
  and returns, cleans up structure initializations, and removes unused
  variables to eliminate warning messages.  The debug print macro is also
  modified to handle a variable number of arguments.
- patch basically stubs out the GetContext function for uClibc and allows
for any
  other system to be added accordingly since uClibc doesn't provide the
function
  on later builds.
- Added code to check whether or not "ffffffff" is returned on some 64bit
  machines.
- Fix for defect 17215 in nanosleep02
- patch adds a missing include file, function return types
  and returns, and typecasts some variables to eliminate warning messages.
  GNU_SOURCE is also added to CFLAGS in the makefile, since otherwise
  the 'pselect' declaration is not found in some build environments.
- Fix for defect 17723 pTrace01.c
- patch adds missing include files and declares return types
  to eliminate warning messages for setfsuidxx.c
- TEST_ERRNO fix to display as a long int.
- Change sigrelse01 tests to eliminate duplicate function prototypes.
- Change to sigrelse01 to use time.h vs define in program.
- Fix for defect 17974, Strace/Ptrace hangs
- patch adds missing include files, function prototypes and
  returns, and removes unused variables to eliminate warning messages.
  It also corrects some sprintf format warnings and replaces 'abortx' with
  a version that accepts a variable number of arguments.
- The "generate.sh" script was mistakenly removed...added it back.
- Updates to check for connection failure vs unauthorized access fail in
ftp02_s1, ftp03, ftp04, ftp05
- Cleanup - Removed the datafile directory, because this is created using
the generate.sh
  script..which is called in the Makefile

Marty Ridgeway
Linux Test Project
Linux Technology Center
IBM Corporation

Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

