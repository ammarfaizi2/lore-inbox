Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSLUV2q>; Sat, 21 Dec 2002 16:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSLUV2q>; Sat, 21 Dec 2002 16:28:46 -0500
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:8680 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id <S264854AbSLUV2q>;
	Sat, 21 Dec 2002 16:28:46 -0500
Date: Sat, 21 Dec 2002 22:36:51 +0100
From: Henrik =?iso-8859-1?Q?St=F8rner?= <henrik@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-ac2: sound problems when using realplayer
Message-ID: <20021221213651.GA3354@hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got a new motherboard based on the KT400 chipset (Soltek
SL75-FRV, in case it matters). With 2.4.20-ac2, sound works 
fine, except when using RealPlayer for streaming audio or
video. I get tons of this message:

Assertion failed! val <= (chan->frag_size * chan->frag_number),via82cxxx_audio.c,via_dsp_ioctl,line=3065

and the resulting audio is pretty horrible (it stutters, stops,
pauses, repeats fragments etc).

Kernel config: 

CONFIG_SOUND=m
CONFIG_SOUND_VIA82CXXX=m
CONFIG_MIDI_VIA82CXXX=y


If you need any other info, let me know.

-- 
Henrik Storner <henrik@hswn.dk> 
