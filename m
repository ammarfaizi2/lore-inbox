Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUBKQt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 11:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUBKQt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 11:49:57 -0500
Received: from math.ut.ee ([193.40.5.125]:44453 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265951AbUBKQtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 11:49:39 -0500
Date: Wed, 11 Feb 2004 18:49:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Takashi Iwai <tiwai@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
In-Reply-To: <s5hwu6ta7oh.wl@alsa2.suse.de>
Message-ID: <Pine.GSO.4.44.0402111845200.19304-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hmm, please show /proc/asound/card0/codec97#0/ac97#0-0 and
> ac97#0-0+regs files again?

0-0/0: Analog Devices AD1885

Capabilities     : -headphone out-
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : Analog Devices Phat Stereo

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 18901Hz
PCM ADC          : 48000Hz



AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

(this is after playing it 22 KHz)

0:00 = 0410
0:02 = bf3f
0:04 = 1010
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0909
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 0001
0:2a = 0001
0:2c = 49d5
0:2e = 0000
0:30 = 0000
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 2000
0:72 = 0300
0:74 = 1000
0:76 = 0000
0:78 = bb80
0:7a = 49d5
0:7c = 4144
0:7e = 5360


And after playing a 48 KHz sound, it changes to
PCM front DAC    : 41147Hz
PCM ADC          : 48000Hz

and regs changes to
0:2c = a0bb
0:7a = 49d5


-- 
Meelis Roos (mroos@linux.ee)

