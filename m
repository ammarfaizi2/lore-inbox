Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUGGS1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUGGS1J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUGGS1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:27:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:8588 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265287AbUGGSZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:25:49 -0400
Subject: [ANNOUNCE] July release of LTP now available
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF427BD1FE.CFBB3CB4-ON85256ECA.00652CC1-86256ECA.00653DFE@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Wed, 7 Jul 2004 13:25:43 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 HFB2|May 18, 2004) at
 07/07/2004 14:25:46
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Changelog:

LTP-20040707
- Added a new test for bind() written by Dan Jones.
- Jacky Malcles added support for ext3 and some cleanup code.
- Fixes to fix DMAPI defect
- Changes for eliminating dmapi.h
- Applied patch from Gary Williams to change malloc() to calloc() b/c some
  archs don't like the use of uninitialized memory.
- Fix typo and change i to a 1 in the bufcmp function in diotest_routines.c
- Applied patch from Gary Williams that added an optional forth arguement
to
 semctl as a union, not a pointer to pointer, b/c pointer to pointer causes
ppc
 to explode.  Union will automagically interpret the union as a pointer as
 necessary....now works on multiple archs.
- Made sure that the shm segment is cleaned up if the shmat() fails.
- Applied patch from Wu Zhou to correctly cleanup in case of a failure.
- Added definition for SHM_HUGETLB for cases where this is not defined.
- Applied patch from Steve Hill and Gary Williams for MIPS.
- Applied a timing fix to allow the test to run on more architectures.
- Applied results cleanup patch from Gary Williams.
- Corrected the logic in the test to use -lepoll or not.
- Applied PASS message cleanup patch from Gary Williams
- Fix invalid syntax "if undefined" in modify_ldt tests
- Applied patch from Gary Williams for personality() tests to initialize
  PER_LINUX so we can clearly see if the desired changes occur.
- Updated to Posixtestsuite-1.4.3


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

