Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbUJ0Vml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbUJ0Vml (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUJ0VjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:39:03 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:33133 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S262900AbUJ0Vcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:32:31 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF45330B99.149A2C07-ON86256F3A.00757C16@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Wed, 27 Oct 2004 16:30:44 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/27/2004 04:30:47 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>the network one could perhaps be related to the network deadlocks
>reported by others. Would be nice to turn on RWSEM_DETECT_DEADLOCKS and
>to use a serial logging if possible.
Would be nice but I don't have serial logging available at this point.
I may be able to set it up in a couple of days though.

>does the audio test use alot of CPU time? In that case it would be
>normal for the RT task to 'lock' the system up. In any case it would be
>nice to try 0.4.2 because it has more check-preemption fixes affecting
>both UP and SMP systems.
I am aware of slow responses normally during tests. However the audio
test should only use one CPU out of two. The other CPU is busy as well
with a cpu burner (nice 10) but that should leave me CPU cycles
to move the mouse, swap windows, etc.  The "lock up" I saw this time
was a lot more severe (no mouse motion for several minutes at a time).
I knew the system was still running since the audio continued to play.

I'll try another build in the morning with whatever your latest is.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

