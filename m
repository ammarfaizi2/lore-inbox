Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270023AbRHMJQy>; Mon, 13 Aug 2001 05:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270021AbRHMJQj>; Mon, 13 Aug 2001 05:16:39 -0400
Received: from dsl092-007-197.sfo1.dsl.speakeasy.net ([66.92.7.197]:59659 "EHLO
	earth.zigamorph.net") by vger.kernel.org with ESMTP
	id <S270012AbRHMJPX>; Mon, 13 Aug 2001 05:15:23 -0400
Date: Mon, 13 Aug 2001 09:21:36 +0000 (UTC)
From: Adam Fritzler <mid@zigamorph.net>
To: linux-kernel@vger.kernel.org
Subject: es1371 in 2.4.x
Message-ID: <Pine.LNX.4.21.0108130915120.16961-100000@earth.zigamorph.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there known issues with es1371 in 2.4.x?

I know there were some issues with VIA chipsets, but I am using an Intel 
440GX+ SMP board.

The mixer works fine, I just can't play any audio.  Trying to play audio
with anything results in the process (including just cat) getting stuck in
the D state until broken.  No audio makes it out on the PCM channel, not
even a pop or a buzz. 

The machine I'm using has been running 2.4.1, where es1371 did not work
either.  I upgraded to 2.4.8 (and ac2) today, still doesn't work.

es1371: version v0.30 time 00:44:50 Aug 13 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
es1371: found es1371 rev 6 at io 0x3080 irq 20
es1371: features: joystick 0x0
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)

Any help is appreciated.

af.

