Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUGVQPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUGVQPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 12:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUGVQPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 12:15:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:28297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266704AbUGVQP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 12:15:27 -0400
Date: Thu, 22 Jul 2004 09:15:24 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <linux-aio@kvack.org>, <linux-osdl@osdl.org>, <mason@suse.com>
Subject: aio-stress test added to OSDL STP 
Message-ID: <Pine.LNX.4.33.0407201554410.13228-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

'aio-stress' is now available as a new test on the Scalable Test
Platform:
   http://www.osdl.org/lab_activities/kernel_testing/stp/

We'd (especially cliffw) like to apologize to akpm for taking way too
long to do this.

Here are results for linux-2.6.7 on a 2CPU host:
   http://khack.osdl.org/stp/295155/

The test runs on our 1, 2 and 4 CPU hosts.  By default it runs with
2 X 1G files, 4 X 1G files and 8 X 1G files on those hosts, respectively.
Each request runs once with the '-O' option (on 2.6 kernels) and once
without.  It is compiled with libaio-0.3.99-2.

Most of the usual options are available:  -r for record size,
-s for file size, -t for number of threads, -S for O_SYNC with writes.
Additionally, -F sets the number of files and -f sets file system type.

We will run it automatically on the mainline kernels.

Thanks;

Judith Lebzelter
OSDL


