Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTAILOJ>; Thu, 9 Jan 2003 06:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTAILOJ>; Thu, 9 Jan 2003 06:14:09 -0500
Received: from cibs9.sns.it ([192.167.206.29]:8720 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S264944AbTAILOH>;
	Thu, 9 Jan 2003 06:14:07 -0500
Date: Thu, 9 Jan 2003 12:22:48 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: oss modules unknown symbols in 2.5.55
Message-ID: <Pine.LNX.4.43.0301091220460.8091-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI, sound ad modules in kernel 2.5.55 down not work anymore, because modules
cannot be loaded due to unknown symbols:

soundcore: Unknown symbol errno
i810_audio: Unknown symbol register_sound_mixer
soundcore: Unknown symbol errno
sound: Unknown symbol register_sound_dsp
v_midi: Unknown symbol midi_devs
soundcore: Unknown symbol errno
sound: Unknown symbol register_sound_dsp
opl3: Unknown symbol note_to_freq
soundcore: Unknown symbol errno
sound: Unknown symbol register_sound_dsp
mpu401: Unknown symbol do_midi_msg
soundcore: Unknown symbol errno
sound: Unknown symbol register_sound_dsp
uart401: Unknown symbol midi_devs
sound: Unknown symbol register_sound_dsp
opl3: Unknown symbol note_to_freq
soundcore: Unknown symbol errno

Hope this helps

Luigi

p.s.
yes, I know I should use alsa, but I like OSS...





