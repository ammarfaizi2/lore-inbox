Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUKHS6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUKHS6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbUKHSzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:55:42 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19882 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261193AbUKHSyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:54:19 -0500
Message-ID: <418FC082.8090706@engr.sgi.com>
Date: Mon, 08 Nov 2004 10:52:50 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech <lse-tech@lists.sourceforge.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: [PATCH 2.6.9 0/2] new enhanced accounting data collection
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In earlier round of discussion, all partipants favored  a common
layer of accounting data collection.

This is intended to offer common data collection method for various
accounting packages including BSD accounting, ELSA, CSA, and any other
acct packages that use a common layer of data collection.

This patchset consists of two parts: acct_io and acct_mm. Discussion
identified that improved data collection in the area of I/O and Memory
are useful to larger systems.

acct_io:
         collects per process data on charater read/written in bytes
         and number of read/write syscalls made.

acct_mm:
         collects per process data on rss and vm total usage and
         peak usage.

Andrew, this new version incorporated feedback from your prior comment.


Best Regards,

Jay Lan - Linux System Software
Silicon Graphics Inc., Mountain View, CA

