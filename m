Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWI3AD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWI3AD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWI3AD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:03:57 -0400
Received: from www.osadl.org ([213.239.205.134]:61843 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932362AbWI3AD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:03:56 -0400
Message-Id: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:18 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 00/23] 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are pleased to announce the next version of our "high resolution 
timers" and "dynticks" patchset, which implements two important features 
that Linux lacked for many years.

The patchset is against 2.6.18-mm2. (Since our last release there were 
no big changes, other than bugfixes and internal releasification 
cleanups, and the merge to -mm. The queue is bisect-friendly.)

If review and feedback is positive we'd like this patchset to be added 
to the 2.6.19 kernel. It has been maintained ontop of ktimers initially 
(more than a year ago), and then ontop of hrtimers (after ktimers were 
renamed to hrtimers and the hrtimer subsystem went upstream in January). 
Various -hrt iterations have been announced on lkml numerous times in 
the past year.

Now that the hrtimers subsystem and most of John Stultz Generic Time Of 
Day work is upstream, this patchset is straightforward and carries 
little risks if high-res timers are turned off (which is the default).

This patchset has been tested on various i686 systems. (We have the 
x86_64 patches too, but we'd like to concentrate on this first wave 
initially.)

The patchset can also be found at:

  http://www.tglx.de/projects/hrtimers/2.6.18-mm2/patch-2.6.18-mm2-hrt-dyntick1.patches.tar.bz2

	Thomas, Ingo

--

