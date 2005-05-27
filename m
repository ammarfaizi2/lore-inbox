Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVE0HhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVE0HhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVE0HbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:31:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10472 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261940AbVE0H22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:28:28 -0400
Date: Fri, 27 May 2005 09:28:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: George Anzinger <george@mvista.com>, Will Dyson <will.dyson@gmail.com>,
       john cooper <john.cooper@timesys.com>
Subject: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-10
Message-ID: <20050527072810.GA7899@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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


i have released the -V0.7.47-10 Real-Time Preemption patch, which can be 
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

Changes:

 - posix-timer fixes (George Anzinger )

 - RPC timers fix (John Cooper)

 - x64 build fix (Will Dyson)

to build a -V0.7.47-10 tree, the following patches have to be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.11.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.12-rc5.bz2
   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.12-rc5-V0.7.47-10

	Ingo
