Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSKDWmP>; Mon, 4 Nov 2002 17:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKDWmP>; Mon, 4 Nov 2002 17:42:15 -0500
Received: from fmr02.intel.com ([192.55.52.25]:6900 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262821AbSKDWmO>; Mon, 4 Nov 2002 17:42:14 -0500
Message-ID: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com>
From: "Geoff Gustafson" <geoff@linux.co.intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] Open POSIX Test Suite
Date: Mon, 4 Nov 2002 14:48:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to announce a new project to develop and/or assemble a GPL test
suite for POSIX APIs. The tests will focus on conformance to the IEEE Std
1003.1-2001, but will also include separate functional and stress tests.

The project's current approach to conformance testing is to record
assertions
from a close reading of the POSIX specifications, and write minimal test
cases
that prove or disprove these assertions. The test suite will be independent
of
specific API implementations, and will eventually be easily configurable to
work with different implementations. The project aims for OS independence,
using only POSIX APIs, the autoconf suite, and simple shell support.
However,
it is currently only being tested on Linux.

Ultimately, the plan is to use the test suite to evaluate current support in
Linux, as well as new implementations being considered in the open source
community, and then contribute patches or at least bug reports (with a
minimal
test case) to the appropriate places, like LKML.

Contributions of any test cases, review of the work, discussion of the
approach, etc. are very welcome. Join the development mailing list,
posixtest-discuss. The initial focus is on Signals, Message Queues, Threads,
Semaphores, and Clocks & Timers, based on current interests and resources.
You can help in these areas, or start work on another area of the spec.
There
will need to be some uniformity across the suite, but many details have yet
to
be worked out, so your involvement in those decisions help a lot.

For more information, see the project website at
http://posixtest.sourceforge.net

Thanks,

-- Geoff Gustafson

These are my views and not necessarily those of my employer.

