Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVDVG11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVDVG11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 02:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVDVG11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 02:27:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:36329 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261729AbVDVG1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 02:27:24 -0400
Date: Fri, 22 Apr 2005 08:27:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
Message-ID: <20050422062714.GA23667@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu> <20050421073537.GA1004@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421073537.GA1004@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the -V0.7.46-01 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this includes fixes from Daniel Walker, which could fix the plist 
related slowdown bugs:

 - fix plist_del_init() argument order bug

 - fix plist related priority calculation bug in __up_mutex()

to build a -V0.7.46-01 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc3.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc3-V0.7.46-01

	Ingo
