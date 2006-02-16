Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWBPWhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWBPWhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWBPWhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:37:05 -0500
Received: from pool-71-161-48-129.clppva.east.verizon.net ([71.161.48.129]:33487
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S1750767AbWBPWhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:37:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17396.65161.567436.689494@ccs.covici.com>
Date: Thu, 16 Feb 2006 17:36:57 -0500
From: John covici <covici@ccs.covici.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with SB Live using 2.6.15.3
X-Mailer: VM 7.17 under Emacs 22.0.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having problems using my SBLive card (details of which
card below), with Linux 2.6.15 kernel.  It works fine in 2.6.14, but
alsa mixers refuse to work in the 15 series.  Here is the output when
modprobing snd-emu10k1 .

modprobe snd-emu10k1
vendor=0x1102, device=0x2, subsystem_vendor_id=0x80661102, subsystem_id=0x8066
Sound card name=SB Live [Unknown], vendor=0x1102, device=0x2, subsystem=0x80661102.
Setting up ALSA...ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback Volume',0,0,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument
done.


I did this with no asound.state file at all, so I don't know where it
got this error from.  I tried doing stores and removing what I thought
were duplicate controls, but no joy.

Any assistance would be appreciated.


-- 
Your life is like a penny.  You're going to lose it.  The question is:
How do
you spend it?

         John Covici
         covici@ccs.covici.com
