Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVCSEDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVCSEDI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 23:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbVCSEDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 23:03:08 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20356 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262400AbVCSEDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 23:03:06 -0500
Subject: Latency tests with 2.6.12-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Jack O'Quin" <joq@io.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 23:03:04 -0500
Message-Id: <1111204984.12740.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did the same quick latency tests with 2.6.12-rc1 that I posted about
for 2.6.11 a few weeks ago.

2.6.12-rc1 is significantly better than 2.6.11.  Running JACK at 64
frames (1.3 ms) works very well.  I was not able to produce xruns even
with "dbench 64", which slows the system to a crawl.  With 2.6.11, I
could easily produce xruns with much lighter loads.

It would appear that the latency issues related to the 4 level page
tables merge have been resolved.

Lee

