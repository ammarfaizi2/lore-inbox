Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVDMVtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVDMVtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 17:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDMVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 17:49:01 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2274 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261210AbVDMVs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 17:48:59 -0400
Subject: weird X problem - priority inversion?
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 17:48:58 -0400
Message-Id: <1113428938.16635.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem with the RT preempt kernels where xscreensaver
will cause the X server to consume excessive CPU, starving other
processes.  This should not happen as xscreensaver runs at the highest
nice value.  It seems that there's some kind of priority inversion
happening between the high prio X server and low prio xscreensaver.

This seems like an X problem to me, but could the kernel be involved?

Lee

