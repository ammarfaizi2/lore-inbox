Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSKEAhe>; Mon, 4 Nov 2002 19:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264914AbSKEAhd>; Mon, 4 Nov 2002 19:37:33 -0500
Received: from fmr01.intel.com ([192.55.52.18]:42982 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S264908AbSKEAhc>;
	Mon, 4 Nov 2002 19:37:32 -0500
Message-ID: <016601c28464$6f6d1110$7fd40a0a@amr.corp.intel.com>
From: "Geoff Gustafson" <geoff@linux.co.intel.com>
To: "Christopher Yeoh" <cyeoh@samba.org>, <linux-kernel@vger.kernel.org>
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com> <15815.2399.566974.940599@gargle.gargle.HOWL>
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
Date: Mon, 4 Nov 2002 16:44:01 -0800
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

Christopher Yeoh writes:
> Have you looked at the LSB test suites yet? They already cover much of
> what you plan on writing tests for, though we would welcome any
> volunteers who would like to increase the coverage.  Most of the tests
> suites are released under the Artistic License, with quite a bit of
> the code donated by the Open Group (originally from the Unix
> certification tests).

One issue is that this new project is primarily concerned with testing parts of
the spec that have not been fully supported in Linux so far. These are the kind
of things that are not included in LSB yet, so they wouldn't be appropriate in
LSB's test suite.

Another problem is the overhead of the TET framework. One of the goals of this
the new test suite is to have test cases which are utterly minimal. So far, each
test case has its own main() function and a bare minimum of surrounding code.
The idea is that when a bug is found, this one .c file can be sent to the
appropriate developer, and without any learning curve, they have the ability to
find their bug. I don't think LKML wants to see TET code posted here. :)

-- Geoff Gustafson

These are my views and not necessarily those of my employer.

