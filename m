Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135276AbRD2AXG>; Sat, 28 Apr 2001 20:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135602AbRD2AWq>; Sat, 28 Apr 2001 20:22:46 -0400
Received: from www.mammoth.org ([204.26.91.1]:47628 "EHLO www.mammoth.org")
	by vger.kernel.org with ESMTP id <S135276AbRD2AWm>;
	Sat, 28 Apr 2001 20:22:42 -0400
Date: Sat, 28 Apr 2001 19:22:40 -0500 (CDT)
From: josh <skulcap@mammoth.org>
To: linux-kernel@vger.kernel.org
Subject: via82cxxx audio fun
Message-ID: <Pine.LNX.4.20.0104281913340.18780-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel: 2.4.4

Well, for all those people getting "audio drain" messages
when trying to play audio with your via82cxxx driver try
passing the "noapic" option to your kernel on bootup to
see if it works.  

I did manage to get mine to work, but only with xmms.  When I
try to use other programs, like mplayer or mtv, I get these kernel
messages
*********************************
Assertion failed! card->ch_out.is_active,via82cxxx_audio.c,via_dsp_poll,line=2278
Assertion failed! card->ch_out.is_active,via82cxxx_audio.c,via_dsp_poll,line=2278
Assertion failed! card->ch_out.is_active,via82cxxx_audio.c,via_dsp_poll,line=2278
*********************************

The audio ends up playing very very fast... its pretty funny, but
not very useful :)  Programs like mpg123 still wont play anything
(i assume due to the rate locked codec).  Oh, and I cant get the
mixer to work... with any program.  Its like it isnt there.

thnx in adv

                          www.mammoth.org/~skulcap
**********************************************BEGIN GEEK CODE BLOCK************
"Sometimes, if you're perfectly      * GCS d- s: a-- C++ ULSC++++$ P+ L+++ E--- 
still, you can hear the virgin       * W+(++) N++ o+ K- w--(---) O- M- V- PS-- 
weeping for the savior of your will."* PE Y+ PGP t+ 5 X+ R !tv b+>+++ DI++ D++  
 --DreamTheater, "Lines in the Sand" * G e h+ r-- y-   (www.geekcode.com)
**********************************************END GEEK CODE BLOCK**************

