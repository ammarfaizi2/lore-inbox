Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288560AbSAHXU3>; Tue, 8 Jan 2002 18:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288558AbSAHXUT>; Tue, 8 Jan 2002 18:20:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20359 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288557AbSAHXUJ>; Tue, 8 Jan 2002 18:20:09 -0500
Date: Tue, 8 Jan 2002 17:02:34 -0600 (CST)
From: Paul Larson <plars@austin.ibm.com>
X-X-Sender: <plars@eclipse.ltc.austin.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Ltp-20020108
Message-ID: <Pine.LNX.4.33.0201081701550.27666-100000@eclipse.ltc.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Test project ltp-20020108 has been released.  For more
information about the Linux Test Project, or to download the testsuite,
see our website at http://ltp.sourceforge.net.

This release contains many enhancements and bugfixes.  The following
testsuites have also been contributed to this release:

Multithreaded floating point stress suite developed by Bull and IBM
dealing with:
 -Trigonometric (acos, asin, atan, atan2, cos, sin, tan)
 -Euclidean distance function (hypot)
 -Computes the natural logarithm of the gamma function (lgamma)
 -Functions that manipulate floating-point numbers (modf, ldexp, frexp)
 -Exponential and logarithmic functions (exp, log, log10)
 -Hyperbolic (cosh, sinh, tanh)
 -Bessel (j0, j1, y0, y1)
 -Power functions (ceil, fabs, floor, fmod, pow, sqrt)

Apple's fsx-linux NFS test suite
This test does various operations over NFS such as seeks, IO, and changes
to a test file to try to confuse NFS.  It watches for data corruption
while doing these operations.  This test has been set up to work over NFS,
or on local file systems.

LTP-20020108 Changelog
----------------------
o       fixed IDcheck.sh to work with bash1 (Nate Straz)
o       updated menu script (Robbie Williamson)
o       reset errno to 0 at the beginning of TEST macro (Paul Larson)
o       added floating point stress tests (Bull/IBM)
o       added fsx-linux NFS tests (Apple)
o       define GLIBC_SIGACTION_BUG for sigaction02 (Robbie Williamson)
o       removed bogus testcase from dup201 test (Paul Larson)
o       fixed recvfrom01 case 5 (Wayne Boyer)
o       workaround for smp issue with waitpid12 (Manfred Spraul)




