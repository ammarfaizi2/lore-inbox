Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbTKJQDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTKJQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:03:42 -0500
Received: from ns.schottelius.org ([213.146.113.242]:33228 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S263942AbTKJQDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:03:39 -0500
Date: Mon, 10 Nov 2003 17:03:48 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: Matt_Wu@acersoftech.com.cn
Subject: Ali5451: Mixer Problems
Message-ID: <20031110160348.GZ25124@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I can only set the volume on or off, but nothing else, no
adjusting.

modules:
snd_pcm_oss            44132  1 
snd_mixer_oss          15136  1 snd_pcm_oss
snd_ali5451            15396  1 
snd_ac97_codec         43940  1 snd_ali5451
snd_pcm                67652  2 snd_pcm_oss,snd_ali5451
snd_page_alloc          6532  1 snd_pcm
snd_timer              17796  1 snd_pcm
snd                    32804  6
snd_pcm_oss,snd_mixer_oss,snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
soundcore               5216  2 snd

lspci:
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controlle
r Audio Device (rev 02)
        Subsystem: Elitegroup Computer Systems: Unknown device 0f22
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort
- <MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at effac000 (32-bit, non-prefetchable)
[size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot
+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



Anyone any idea whats wrong?

Nico
