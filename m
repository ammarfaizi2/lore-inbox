Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTH3Aeo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 20:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTH3Aeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 20:34:44 -0400
Received: from web20714.mail.yahoo.com ([66.163.169.155]:14266 "HELO
	web20714.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262301AbTH3Ael (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 20:34:41 -0400
Message-ID: <20030830003440.66145.qmail@web20714.mail.yahoo.com>
Date: Fri, 29 Aug 2003 21:34:40 -0300 (ART)
From: =?iso-8859-1?q?Gaston=20Gransis?= <give54sh2@yahoo.com.ar>
Subject: Via 8235 rear sound
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody:
  i came hear as the last resource ... i have tried
with alsa mailing list, and nobody answered me ...
I installed this driver(kernel 2.6.0-test2) and
compiled all the alsa libraries.
When i play sound everything works great except for
the rear channel, and the center/lfe channel. 

i have tried with 
alsaplayer -d hw:0,1 but the sound stills go out in
the front channel(only).

 cat /proc/asound/cards
0 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 at 0xe000, irq 5



 cat /proc/asound/card0/ac97#0
0-0/0: Avance Logic ALC650 rev 0
 
Capabilities     :
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Realtek 3D Stereo Enhancement
 
Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=1 AMAP LDAC SDAC CDAC
DSA=0 SPDIF DRA VRA
Extended status  : SPCV LDAC SDAC CDAC SPDIF=res SPDIF
VRA
PCM front DAC    : 48000Hz
PCM Surr DAC     : 48000Hz
PCM LFE DAC      : 48000Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Copyright Category=0x2
Generation=1 Rate=48kHz



 cat /proc/asound/pcm
00-00: VIA 8235 : VIA 8235 : playback 4 : capture 1
00-01: VIA 8235 : VIA 8235 : playback 1 : capture 1

 cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.4
(Mon Jun 09 12:01:18 2003 UTC).
Compiled on Aug 25 2003 for kernel 2.6.0-test2.


 cat /proc/asound/devices
  0: [0- 0]: ctl
 17: [0- 1]: digital audio playback
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer



Sorry if i bother anyone ... this is the last place on
earth.

Any help would be apreciated!
Thanks


------------
Internet GRATIS es Yahoo! Conexión
4004-1010 desde Buenos Aires. Usuario: yahoo; contraseña: yahoo
Más ciudades: http://conexion.yahoo.com.ar
