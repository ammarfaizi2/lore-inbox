Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291711AbSBHShy>; Fri, 8 Feb 2002 13:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291707AbSBHShr>; Fri, 8 Feb 2002 13:37:47 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:20108 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S291711AbSBHShc>; Fri, 8 Feb 2002 13:37:32 -0500
Subject: [Announcement] New Release of LTP testsuite available
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFAFA30268.F0CA3EA1-ON85256B5A.006611A0@raleigh.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Fri, 8 Feb 2002 12:37:45 -0600
X-MIMETrack: Serialize by Router on D04NMS96/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/08/2002 01:37:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test project ltp-20020207 has been released.  For more
information about the Linux Test Project,
or to download the testsuite, see our website at http://ltp.sourceforge.net
.  This release contains enhancements
to support execution on the following additional architectures:

    IBM z-Series mainframe
    PowerPC
    Intel IA-64

New test results, that include these new architectures, are published at
http://ltp.sourceforge.net/results.html. Initial
support for an IPv6 network environment were also added to the testsuite.
Modifications were made to the
Makefiles to allow non-root and cross-compiler compilation, and numerous
bugfixes are implemented.

Change Log:
------------
o       added support for cross-compiling (Todd Inglett)
o       added LKML's cache_leak testcase to ltp/scratch (Nate Straz)
o       added IPv6 support (Robbie Williamson)
o       added "gethost" to /tools (Robbie Williamson)
o       fixed the race conditions in the float tests and removed
          the sleeps (Robbie Williamson)
o       enabled non-root make authority (Paul Larson)
o       separated compilation into "make" and "make install" (Paul Larson)
o       added ipc_stress test (Manoj Iyer)
o       added pthreads_stress test (Manoj Iyer)
o       made changes to support architecture independence (Manoj Iyer &
Paul Larson)
o       closed the following bugs:
       504960, 505108, 504613, 504616, 491283, 506689, 508055, 506692,
508074
       491289, 506662, 511383, 511391, 511427, 511494, 504649, 514050
       (Manoj Iyer, Paul Larson, and Robbie Williamson)


- Robbie

Robert V. Williamson
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 638-9295
http://ltp.sourceforge.net

