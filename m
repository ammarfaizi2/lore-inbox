Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVAFUXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVAFUXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVAFUSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:18:41 -0500
Received: from zeus.kernel.org ([204.152.189.113]:3779 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263014AbVAFUQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:16:10 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-mm1-V0.7.34-00
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFB0005E29.8FDCDD2D-ON86256F81.00692C36@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 6 Jan 2005 13:15:41 -0600
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 01/06/2005 01:22:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 4 Jan 2005 10:45:18 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
>
> >   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
> >   http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10
/2.6.10-mm1/2.6.10-mm1.bz2
> >
http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-mm1-V0.7.34-00

>
> Hi,
>
> something is wrong with 34-01 and ALSA:

[snip - detailed error messages]

This is a known problem with -mm1 and the ALSA people already fixed it.
The change log for -mm2 indicates it should be in that version.

A work around is to ENABLE power management. Another possible solution
is to apply the patch I already provided in a lkml email message. See

http://groups-beta.google.com/group/linux.kernel/attach/4fc6393590a2fa25/ac97-fix-nopm.patch?part=2
for the patch or

http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/191dcbdb2db8683a/10b2db7bba380ae4#10b2db7bba380ae4
for the context of the email exchange. This is NOT the same fix the ALSA
people provided - but it worked for me.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

