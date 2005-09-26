Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVIZHBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVIZHBd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVIZHBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:01:33 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:49849 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932417AbVIZHBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:01:33 -0400
Date: Mon, 26 Sep 2005 09:02:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       dwalker@mvista.com, emann@mrv.com, yang.yi@bmrtech.com
Subject: 2.6.14-rc2-rt2
Message-ID: <20050926070210.GA5157@elte.hu>
References: <20050913100040.GA13103@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913100040.GA13103@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i have released the 2.6.14-rc2-rt2 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

the biggest change is the merge to the 2.6.14 tree, but there are also 
updates all across the board: lots of ktimer updates and fixes from 
Thomas Gleixner, an important PI fix from Steven Rostedt, and lots of 
other details.

Changes since 2.6.13-rt6:

 - tons of ktimer updates: build fixes, SMP fixes and more (Thomas 
   Gleixner)

 - PI fix (Steven Rostedt)

 - ntfs fix for bit-spin-locks (Eran Mann)

 - updates/fixes in preparation of the ARM merge (Daniel Walker)

 - latency histogram cleanups (Yi Yang)

 - merge to 2.6.14-rc2

 - sysfs/scsi interaction workaround to get aic7xxx to boot

to build a 2.6.14-rc2-rt2 tree, the following patches should be applied:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.13.tar.bz2
   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.14-rc2.bz2
   http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rc2-rt2

	Ingo
