Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVCLKPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVCLKPI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVCLKPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:15:08 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:10124 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261180AbVCLKPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:15:03 -0500
Date: Sat, 12 Mar 2005 02:14:50 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-xfs@oss.sgi.com
cc: mc@cs.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CHECKER] XFS doesn't respect mount -o sync (XFS, 2.6.11)
Message-ID: <Pine.GSO.4.44.0503120202580.10379-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We are from the Stanford Checker team and are working on a file system
checker called FiSC.  We checked XFS and found that even when a XFS
partition is mounted -o sync, file system operations are still not sync'ed
correctly.

A simple test case would be something like this:
mkdir 0001
reboot -f -n
After reboot, directory 0001 is lost.
Let me know if you need any more information to reproduce the warning.

We are not sure if this is the expected behavior on XFS or not, so your
inputs on this are well appreciated.

-Junfeng

