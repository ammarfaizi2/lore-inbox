Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVBGPI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVBGPI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVBGPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:08:29 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:52921 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261152AbVBGPI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:08:28 -0500
Date: Mon, 7 Feb 2005 16:08:23 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Real-Time Preemption and UML?
In-Reply-To: <20050207092128.GA19189@elte.hu>
Message-Id: <Pine.OSF.4.05.10502071601480.29801-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am trying to compile and run UM-Linux with PREEMPT_REALTIME. I
managed to get it to compile but it wont start - it simply stops somewhere
in start_kernel() :-(

Have anyone else looked at it?

It doesn't sound like it makes much sense to have PREEMPT_REALTIME for UML
but I thought it was a good developing platform for playing around
before going to the real hardware, where the latency meassurements
of course have to take place. The turn around time should be much shorter
than rebooting a full PC every time and the possibility of getting debug
output in the beginning should also be much better.

Esben

