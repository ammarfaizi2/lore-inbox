Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283466AbRK3CGi>; Thu, 29 Nov 2001 21:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283513AbRK3CG2>; Thu, 29 Nov 2001 21:06:28 -0500
Received: from codepoet.org ([166.70.14.212]:12563 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S283512AbRK3CGQ>;
	Thu, 29 Nov 2001 21:06:16 -0500
Date: Thu, 29 Nov 2001 19:06:17 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: via82cxxx_audio doesn't play audio?
Message-ID: <20011129190617.A3975@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went out the other day and bought an Athlon to replace my aging
celeron 400.  I installed an Epox EP-8KHA+ with an Athlon XP 1600+.
The VIA 8233 Southbridge on the motherboard has builtin audio

    00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 30)
	    Flags: medium devsel, IRQ 11
	    I/O ports at cc00 [size=256]
	    Capabilities: [c0] Power Management version 2

I have enabled CONFIG_SOUND_VIA82CXXX and CONFIG_MIDI_VIA82CXXX
in 2.4.16 and everything seems to be fine.  When I load the
modules I see this:

    Via 686a audio driver 1.9.1
    ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
    via82cxxx: board #1 at 0xCC00, IRQ 11

When I go to play audio, no sound is produced.  The mixer works.
I can load up the bttv drivers and I actually hear audio from
xawtv (so tvaudio is doing something right behind the scenes).
But standard apps such as xmms produce no sound.  Does this
driver not work for anyone else? 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
