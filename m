Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUCaOwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUCaOwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:52:19 -0500
Received: from gprs213-129.eurotel.cz ([160.218.213.129]:25216 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261981AbUCaOwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:52:18 -0500
Date: Wed, 31 Mar 2004 16:52:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: perex@suse.cz, Tjeerd.Mulder@fujitsu-siemens.com, tiwai@suse.de,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Sound on newer arima notebook...
Message-ID: <20040331145206.GA384@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...seems to work okay, except that mixers are strangely renumbered in
aumix. PCM2 has to be set to high if I want to hear something. Master
volume does not do anything.

Dmesg tells me:

Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49 2004 UTC).
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=1 or dxs_support=4 option
         and report if it works on your machine.
PCI: Setting latency timer of device 0000:00:11.5 to 64
usb 2-1: new full speed USB device using address 2
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
ALSA device list:
  #0: VIA 8235 at 0x1400, irq 22

With dxs_support=1 mixers were also renumbered, maybe in slightly
different way.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
