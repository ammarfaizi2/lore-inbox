Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270769AbTG0N0D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 09:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270774AbTG0N0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 09:26:02 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41707 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S270769AbTG0N0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 09:26:01 -0400
Date: Sun, 27 Jul 2003 15:40:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: [patch] sched-2.6.0-test1-G6, interactivity changes
Message-ID: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


my latest scheduler patchset can be found at:

	redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G6

this version takes a shot at more scheduling fairness - i'd be interested
how it works out for others.

Changes since -G3:

 - fix the timeslice granularity inconsistency found by Con

 - further increase timeslice granularity

 - decrease sleep average interval to 1 second

 - fix starvation detection, increase fairness

Reports, testing feedback and comments are welcome,

	Ingo

