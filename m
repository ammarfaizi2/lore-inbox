Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTBOWIX>; Sat, 15 Feb 2003 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTBOWIX>; Sat, 15 Feb 2003 17:08:23 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:60288 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S265250AbTBOWIW>;
	Sat, 15 Feb 2003 17:08:22 -0500
Subject: ALSA broken in 2.5.61
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045347495.682.10.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Feb 2003 23:18:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to use ALSA with my old sb16 in 2.5.61 and it sounds like
hell :) worked fine in 2.5.58.

When trying to use OSS emulation it almost sounds like playing a c64
tape at half speed and the mp3player chews through the song in a few
seconds and I hardly see any interrupts beeing generated for the sb16 in
/proc/interrupts. I see about 1 irq per 2 seconds.

When using native ALSA for playback it sounds almost ok but it's very
choppy, sounds like it skips ahead 0.5-1 seconds every 2 seconds or so.
Forgot to check the interruptrate when trying this.

I've reverted to OSS right now and it sounds great :)

I saw that you've made some rather large changes that went in somewhere
after 2.5.58... Do you have any idea to what might cause this?

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
