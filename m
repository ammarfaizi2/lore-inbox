Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbUEFTvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUEFTvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUEFTvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:51:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:61570 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262961AbUEFTvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:51:06 -0400
Subject: [ANNOUNCE] LTP May release now on ltp.sf.net
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF47F6EA58.26463FB2-ON85256E8C.006CFC50-86256E8C.006D0AE0@us.ibm.com>
From: Marty Ridgeway <mridge@us.ibm.com>
Date: Thu, 6 May 2004 14:50:58 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 6.0.2CF2 HFB2|April 30, 2004) at
 05/06/2004 15:51:04
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





LTP-20040506
- Corrected a bug fix, so that the runalltests.sh script ends correctly and
returns a
  0 or 1 depending on PASS/FAIL result.
- Applied bug fixes from Gernot Payer
- Changes for parameters passed to aio-sparse for correct offsets and
restrictions on sizes.
- Changes to fix error "invalid argument" on parameters for aiodio_sparse
tests
- Relocated the acl tests to /kernel/fs
- Added initial drop of DMapi testcases
- Applied fix from Joe Habermann for the "v" option, where in some cases
the
  routine, sy_mmrw, will pass sbuf.st_size for the msync length without
first
  having done the fstat to populate sbuf.
- Changes to have the directio run a pre-defined number of iterations for
more complete testing
- Fix too many open filehandle problem on direct io tests
- Created a second test that checks how huge pages are mapped in 32-bit and
  64-bit processes.
- Added new test for testing that a normal mmap cannot be mapped into a
  high memory region.
- Added test to map a file to the max size possible.
- Made the tests 64bot friendly.
- Added tests for shmat() calls using hugetlb.
- Corrected tests to allow EACCES or EPERM, which is documented in POSIX.
- Update open_posix_tests to 1.4.1


Linux Test Project
Linux Technology Center
IBM Corporation


Internet E-Mail : mridge@us.ibm.com
IBM, 11501 Burnet Rd, Austin, TX  78758
Phone (512) 838-1356 - T/L 678-1356 - Bldg. 908/1C005
Austin, TX.

