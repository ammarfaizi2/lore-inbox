Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbTKUP6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 10:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbTKUP6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 10:58:51 -0500
Received: from [212.35.254.18] ([212.35.254.18]:1752 "EHLO mail2.midnet.co.uk")
	by vger.kernel.org with ESMTP id S264367AbTKUP6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 10:58:50 -0500
Date: Fri, 21 Nov 2003 15:58:33 +0000
From: Tim Kelsey <accent0@mail2.midnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9-mm4 ans ALSA
Message-Id: <20031121155833.1ab1f5b6.accent0@mail2.midnet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,

Im haveing a problem with ALSA, my sound card is an Analoge Devices AD1981B my lsmod follows:

snd_pcm_oss            48772  0
snd_mixer_oss          17280  1 snd_pcm_oss
nvidia               1701356  12
aes                    31552  1
snd_via82xx            21760  4
snd_pcm                88000  3 snd_pcm_oss,snd_via82xx
snd_ac97_codec         52228  1 snd_via82xx
snd_page_alloc          9220  2 snd_via82xx,snd_pcm
snd_mpu401_uart         6016  1 snd_via82xx
snd_rawmidi            20928  1 snd_mpu401_uart

with mm4 the aplay program exits with a seg fault and the xmms alsa 0.9 output plugin hangs, also any ps -aux or kill/killall commands hang with no output and dont answer a ctrl+c after trying to play somthing via xmms alsa output

in 2.6.0-test9 vanilla all the alsa stuff works fine and i think in 2.6.0-t9-mm3 (ill confirm if it does) but in 2.6.0-t9-mm4 it seems to be broken at least for my card. OSS emulation works fine tho with 2.6.0-t9-mm4 

if any more information would be helpfull to any one please let me know whats needed.

Thanx

TK
