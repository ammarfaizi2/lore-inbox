Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbTIES7d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 14:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbTIES7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 14:59:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:55012 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265665AbTIES7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 14:59:04 -0400
Subject: LTP nightly regression results for
	2.6.0-test4,bk1,bk2,bk3,bk5,bk6,mm1,mm2,mm3-1,mm4,mm5,mm6
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>,
       linstab <linstab@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Sep 2003 13:58:12 -0500
Message-Id: <1062788292.1290.242.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of test results here, the swapoff test failures are related to a
known bug in mkswap under debian unstable so nothing to worry about
there.  If its too alarming to people to see it there, then I can take
it out of the nightly run on this box.

These results and previous results are archived at:
http://developer.osdl.org/dev/ltp/results/

Thanks,
Paul Larson

2.6.0-test4-vs-2.6.0-test4-bk1
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-vs-2.6.0-test4-bk1/
Test Name      2.6.0-test4        2.6.0-test4-bk1     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
gettimeofday   PASS               FAIL                    Y            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               FAIL                    N            N

2.6.0-test4-bk1-vs-2.6.0-test4-bk2
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-bk1-vs-2.6.0-test4-bk2/
Test Name      2.6.0-test4-bk1    2.6.0-test4-bk2     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
gettimeofday   FAIL               PASS                    N            Y
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               FAIL                    N            N

2.6.0-test4-bk2-vs-2.6.0-test4-bk3
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-bk2-vs-2.6.0-test4-bk3/
Test Name      2.6.0-test4-bk2    2.6.0-test4-bk3     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               PASS                    N            Y

*The -bk4 kernel is skipped here because there was some kind of hang
problem with it.  I didn't get a chance to look into it before -bk5 came
out and the problem was fixed there anyway.

2.6.0-test4-bk3-vs-2.6.0-test4-bk5
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-bk3-vs-2.6.0-test4-bk5/
Test Name      2.6.0-test4-bk3    2.6.0-test4-bk5     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

2.6.0-test4-bk5-vs-2.6.0-test4-bk6
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-bk5-vs-2.6.0-test4-bk6/
Test Name      2.6.0-test4-bk5    2.6.0-test4-bk6     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

2.6.0-test4-vs-2.6.0-test4-mm1
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-vs-2.6.0-test4-mm1/
Test Name      2.6.0-test4        2.6.0-test4-mm1     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               FAIL                    N            N

2.6.0-test4-mm1-vs-2.6.0-test4-mm2
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-mm1-vs-2.6.0-test4-mm2/
Test Name      2.6.0-test4-mm1    2.6.0-test4-mm2     Regression  Improvement
-----------------------------------------------------------------------------
fcntl15        PASS               FAIL                    Y            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               PASS                    N            Y

2.6.0-test4-mm2-vs-2.6.0-test4-mm3-1
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-mm2-vs-2.6.0-test4-mm3-1/
Test Name      2.6.0-test4-mm2    2.6.0-test4-mm3-1   Regression  Improvement
-----------------------------------------------------------------------------
fcntl15        FAIL               PASS                    N            Y
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

2.6.0-test4-mm3-1-vs-2.6.0-test4-mm4
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-mm3-1-vs-2.6.0-test4-mm4/
Test Name      2.6.0-test4-mm3-1  2.6.0-test4-mm4     Regression  Improvement
-----------------------------------------------------------------------------
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       PASS               FAIL                    Y            N

2.6.0-test4-mm4-vs-2.6.0-test4-mm5
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-mm4-vs-2.6.0-test4-mm5/
Test Name      2.6.0-test4-mm4    2.6.0-test4-mm5     Regression  Improvement
-----------------------------------------------------------------------------
fcntl15        PASS               FAIL                    Y            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               PASS                    N            Y

*Seems to be some bouncing around on the -mms of fcntl15 failing.  I
need to do some more investigation here to see if the test is failing
randomly on its own, or just with -mm.

2.6.0-test4-mm5-vs-2.6.0-test4-mm6
http://developer.osdl.org/dev/ltp/results/2.6.0-test4/2.6.0-test4-mm5-vs-2.6.0-test4-mm6/
Test Name      2.6.0-test4-mm5    2.6.0-test4-mm6     Regression  Improvement
-----------------------------------------------------------------------------
fcntl15        FAIL               PASS                    N            Y
getgroups03    FAIL               FAIL                    N            N
hangup01       PASS               FAIL                    Y            N
nanosleep02    FAIL               FAIL                    N            N
ptem01         PASS               FAIL                    Y            N
pty01          PASS               FAIL                    Y            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

*The hangup01, ptem01, and pty01 regressions here are all related to an
error on opening /dev/ptmx.  A bug has been filed for this, #1187.


