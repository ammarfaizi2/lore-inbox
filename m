Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310474AbSCGTaW>; Thu, 7 Mar 2002 14:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310481AbSCGTaN>; Thu, 7 Mar 2002 14:30:13 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:39595 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310474AbSCGTaA>; Thu, 7 Mar 2002 14:30:00 -0500
Subject: [ANNOUNCE] ltp-20020307 Released
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF63027D17.B430C25E-ON85256B75.006ADE13@raleigh.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Thu, 7 Mar 2002 13:29:48 -0600
X-MIMETrack: Serialize by Router on D04NMS96/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 03/07/2002 02:29:58 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test project ltp-20020307 has been released. For more information
about the Linux Test Project, or to download the testsuite, see our website
at http://ltp.sourceforge.net.  This release includes enhancements to the
test driver, pan, that allow for more control over testing duration.
Additional tests have been added that cover disk I/O, semaphores, signals,
Streamed Controlled Transmission Protocol (SCTP), and tools for the
scheduler.  Numerous posted bugs were also addressed and closed in this
release, as well.
      We have added a new mailing list for the purpose of publishing and
requesting test results ( ltp-results@lists.sourceforge.net ).  This list
was created to act as a convenient way of keeping a central, archived
place, where anyone can publish the results of tests being run on Linux.
This list may also serve as a place for developers to request others to
test their patches, then reply to the list with results.  We encourage
everyone in the Linux Community to start actively testing Linux and
publishing the results of those tests.  In addition to this list, we've
also added a page of expected LTP failures to the website (
http://ltp.sourceforge.net/expected-errors.php ), and a link to a
whitepaper that details enterprise level testing in Linux (
http://www6.software.ibm.com/devcon/entteswp/EnterpriseWhitePaperv.07.html
).

ChangeLog:
------------
o       fixed IDcheck.sh to prompt for IDs only when missing (Jay Huie)
o       added time duration option to pan (Jay Huie)
o       added 4 more cases to getcwd02 test (Jay Huie)
o       added time-schedule tool by Richard Gooch under sched test
        section (Manoj Iyer)
o       added trace_sched tool under sched test section (Manoj Iyer)
o       added sigpending02 test to syscalls section (Paul Larson)
o       created a KNOWN-FAILURES file to document known
        test failures (Robbie Williamson)
o       added sem02 test to ipc section (Robbie Williamson)
o       added SCTP section to network tests (Robbie Williamson)
o       added disktest by Brent Yardley to io section (Robbie Williamson)
o       closed the following bugs:
        [ #491285 ] recvfrom01 test (Paul Larson)
        [ #491286 ] recvmsg01 test (Robbie Williamson)
        [ #505515 ] perf_lan6 test (Robbie Williamson)
        [ #506536 ] recv01 test (Robbie Williamson)
        [ #514408 ] chown05 (Dave Engebretsen)
        [ #511427 ] pread02 test (Paul Larson)
        [ #516577 ] ftruncate03 test (Jay Huie)
        [ #523055 ] sched_getscheduler test (Paul Larson)
        [ #523137 ] sched_setscheduler02 test (Paul Larson)
        [ #525688 ] sendfile01 (Paul Larson)


- Robbie

Robert V. Williamson
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 638-9295
http://ltp.sourceforge.net

