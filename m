Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbTAZWl4>; Sun, 26 Jan 2003 17:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTAZWlz>; Sun, 26 Jan 2003 17:41:55 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:25096 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S267027AbTAZWlz> convert rfc822-to-8bit;
	Sun, 26 Jan 2003 17:41:55 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [ALSA] opl3sa2 silence
Date: Sun, 26 Jan 2003 23:50:51 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301262350.51389.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

my toshiba tecra 8000 doesn't make a single beep when using the alsa opl3sa2
driver.  the resources are forced by hand (since pnpc_ doesn't work here),
i also tried a quick pnp (no cards) hack, the chip is detected correctly,
but still doesn't make sound. the card shows up in /proc/asound/.
when 'playing' sound, /proc/asound/card0/pcm0p/sub0/status shows nice values.
i used alsamixer to give full volume to all channels, still no results...

OSS opl3sa2 driver is working fine.

thanx for any hints, patches, etc...
-daniel
