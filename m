Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbTCZIsm>; Wed, 26 Mar 2003 03:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbTCZIsm>; Wed, 26 Mar 2003 03:48:42 -0500
Received: from 210-55-37-99.dialup.xtra.co.nz ([210.55.37.99]:260 "EHLO
	riven.neverborn.ORG") by vger.kernel.org with ESMTP
	id <S261505AbTCZIsl>; Wed, 26 Mar 2003 03:48:41 -0500
Date: Wed, 26 Mar 2003 20:59:45 +1200
From: "leon j. breedt" <ljb@neverborn.org>
To: linux-kernel@vger.kernel.org
Subject: No SB Audigy2 analog output in 2.5.66 emu10k1 driver?
Message-ID: <20030326085945.GA4433@riven.neverborn.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i don't know if i'm missing something here, but
i'm getting no output from the analog output (third
from the firewire port) on my SB Audigy2 on 2.5.66 (or
any previous version i've tried for that matter).

i've checked mixer settings, all settable items are on
maximum output.

i have also tried the emu10k1 driver from sourceforge
on 2.4.x, with the same result.

it works fine with the OSS/Linux and windows drivers,
here is the dmesg line:

Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Blaster Audigy (rev.4) at 0xb800, irq 18

i don't know why the request_module was even executed, since i've
compiled everything in:

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y

any suggestions?

thanks,
leon
