Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTHTVbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbTHTVbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:31:17 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:31385 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262234AbTHTVbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:31:10 -0400
Subject: LTP nightly regression results for
	2.6.0-test3-bk2,bk3,bk5,bk6,bk7,mm3,mjb1
From: Paul Larson <plars@linuxtestproject.org>
To: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>, linstab@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Aug 2003 16:30:51 -0500
Message-Id: <1061415052.3909.1733.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here's the latest batch of LTP test results for the latest 2.6 bk
snapshots and mm/mjb trees.  These results and previous results are
archived at: http://developer.osdl.org/dev/ltp/results/

Thanks,
Paul Larson

2.6.0-test3-bk1-vs-2.6.0-test3-bk2
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk1-vs-2.6.0-test3-bk2/
Test Name      2.6.0-test3-bk1    2.6.0-test3-bk2     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
setegid01      FAIL               PASS                    N            Y
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

2.6.0-test3-bk2-vs-2.6.0-test3-bk3
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk2-vs-2.6.0-test3-bk3/
Test Name      2.6.0-test3-bk2    2.6.0-test3-bk3     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
gettimeofday   PASS               FAIL                    Y            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       PASS               FAIL                    Y            N

*** bk4 failed to compile, but the failure was quickly fixed in bk5 ***

2.6.0-test3-bk3-vs-2.6.0-test3-bk5
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk3-vs-2.6.0-test3-bk5/
Test Name      2.6.0-test3-bk3    2.6.0-test3-bk5     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
gettimeofday   FAIL               PASS                    N            Y
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               FAIL                    N            N

2.6.0-test3-bk5-vs-2.6.0-test3-bk6
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk5-vs-2.6.0-test3-bk6/
Test Name      2.6.0-test3-bk5    2.6.0-test3-bk6     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       FAIL               PASS                    N            Y

2.6.0-test3-bk6-vs-2.6.0-test3-bk7
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk6-vs-2.6.0-test3-bk7/
Test Name      2.6.0-test3-bk6    2.6.0-test3-bk7     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
gettimeofday   PASS               FAIL                    Y            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N
syslog04       PASS               FAIL                    Y            N

2.6.0-test3-mm2-vs-2.6.0-test3-mm3
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-mm2-vs-2.6.0-test3-mm3/
Test Name      2.6.0-test3-mm2    2.6.0-test3-mm3     Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N

2.6.0-test3-vs-2.6.0-test3-mjb1
http://developer.osdl.org/dev/ltp/results/2.6.0-test3-vs-2.6.0-test3-mjb1/
Test Name      2.6.0-test3        2.6.0-test3-mjb1    Regression  Improvement
-----------------------------------------------------------------------------
alarm03        FAIL               FAIL                    N            N
getgroups03    FAIL               FAIL                    N            N
nanosleep02    FAIL               FAIL                    N            N
setegid01      FAIL               PASS                    N            Y
swapoff01      FAIL               FAIL                    N            N
swapoff02      FAIL               FAIL                    N            N


