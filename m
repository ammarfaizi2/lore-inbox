Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbUL2Tdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUL2Tdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUL2Tdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:33:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11173 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261400AbUL2Tdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:33:41 -0500
Subject: Latency results with 2.6.10 - looks good
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 29 Dec 2004 14:33:40 -0500
Message-Id: <1104348820.5218.42.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After testing JACK with vanilla 2.6.10, it appears that the scheduling
latency of 2.6.10 is a vast improvement over previous kernel releases.
JACK seems to be usable with a period of 32 and 64 frames, I cannot
produce xruns by moving the mouse or any amount of display or disk
activity.  Previous kernel releases were somewhat worse than Windows XP
in this area, 2.6.10 is definitely better, maybe as good as OSX.

So, it appears that all of the latency fixes going upstream from Ingo
and others have really made a difference.  More testing is needed but it
looks like we may finally have a kernel that's usable (and in fact quite
good) out of the box for low latency audio.  Good work!

Lee

