Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTJZNIw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTJZNIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:08:52 -0500
Received: from port-212-202-177-96.reverse.qdsl-home.de ([212.202.177.96]:33042
	"EHLO fbunet.dyndns.org") by vger.kernel.org with ESMTP
	id S263117AbTJZNIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:08:50 -0500
From: Fridtjof Busse <linux-kernel@fbunet.de>
To: linux-kernel@vger.kernel.org
Date: Sun, 26 Oct 2003 14:08:50 +0100
MIME-Version: 1.0
Content-Disposition: inline
Subject: [2.6.0-test9] VIA823x sound problem
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200310261408.50763@fbunet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I've got a problem with sound with my VIA823x soundcard (ADI AD1980) and 
kernel-2.6 (2.4 works but uses Line-In for output, funny thing).

OSS works, but gives the following error
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
via_audio: ignoring drain playback error -11
Assertion failed! chan->is_active == 
sg_active(chan->iobase),sound/oss/via82cxxx_audio.c,via_chan_maybe_start,line=1388
[some time later]
via_audio: ignoring drain playback error -11
via82cxxx: unknown number of channels
via82cxxx: unknown number of channels
via82cxxx: unknown number of channels

I'm using OSS becase ALSA doesn't seem to work at all (no sound):
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 option and report if it works on your 
machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_valid: codec 0 is not valid [0xfe0000]
codec_valid: codec 0 is not valid [0xfe0000]
[lots more]
ALSA device list:
  #0: VIA 823x rev60 at 0xe000, irq 9

Please CC me, thanks
-- 
Fridtjof Busse

