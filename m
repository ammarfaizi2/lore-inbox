Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUJUNYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUJUNYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUJUNQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:16:31 -0400
Received: from dfw-gate1.raytheon.com ([199.46.199.230]:48970 "EHLO
	dfw-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S270350AbUJUNOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:14:04 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF7C037699.07E90948-ON86256F34.0047151D@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 21 Oct 2004 08:02:18 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/21/2004 08:02:24 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a workaround patch for the boot time BUG, I was able to get ...
 - to single user mode w/o any errors
 - a [NOW] non fatal error getting the network up (telinit 3)
 - no further errors getting the X server up (telinit 5)
 - able to hear sample audio
 - system stayed up all night (daemons were stable...)
This is the first time in about two weeks that I had a reasonably stable
system (last known good is -T3).

I was about to run my normal stress tests when the system locked up.

The symptom was the display stopped updating / no mouse motion. Apparently
caused while I was dragging a window with the mouse (USB). We may still
have problems in that area. No apparent response to Alt-Sysrq keys;
hardware reset was sufficient to reboot.

Will check the system logs to see what I can find.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

