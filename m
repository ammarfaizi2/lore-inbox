Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTBLN4v>; Wed, 12 Feb 2003 08:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTBLN4v>; Wed, 12 Feb 2003 08:56:51 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:42952
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S267263AbTBLN4r>; Wed, 12 Feb 2003 08:56:47 -0500
From: scott thomason <scott-kernel@thomasons.org>
Reply-To: scott-kernel@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: alsa es1968 sound driver broken in 2.5.5x?
Date: Wed, 12 Feb 2003 08:06:36 -0600
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302120806.36310.scott-kernel@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings. I've been trying to make the ALSA PCI es1968 sound 
driver work, for both playback and mic-in recording, with no 
success. I've tried kernel versions 2.5.53, 2.5.59, and 2.5.60, 
with no luck. I believe that it has to do with the driver 
itself, as I can successfully use the ALSA cmipci driver for 
both recording and playback. Fortunately, the cmipci chipset 
sucks for recording, or I may never have had the motivation to 
find and report this bug :)

Unfortunately, I don't know how to give good information for 
debugging, only some half-assed descriptions of the symptoms:

1. KMixer won't show the card, just a big empty spot.

2. My favorite synthesizer program, AlsaModularSyth, crashes 
immediately upon attempted load.

3. Zinf (formerly freeamp) tells me it can't open audio device 
/dev/dsp.

I am using Gentoo 1.4rc1, which means I am using devfs, if that 
helps any.

Please let me know if there is a way I can provide better 
debugging info.
---scott
