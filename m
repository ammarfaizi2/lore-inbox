Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311443AbSC1QmN>; Thu, 28 Mar 2002 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311582AbSC1QmD>; Thu, 28 Mar 2002 11:42:03 -0500
Received: from ghost.anime.pl ([212.182.112.233]:22793 "EHLO ghost.anime.pl")
	by vger.kernel.org with ESMTP id <S311443AbSC1Qlx>;
	Thu, 28 Mar 2002 11:41:53 -0500
Date: Thu, 28 Mar 2002 17:39:07 +0100
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: OSS mixer does not work with second card.
Message-ID: <20020328163907.GA5815@ghost.anime.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Dariush Pietrzak <eyck@ghost.anime.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 I have no idea whom to send/ask this.

[1.] 
mixer can be accessed only by /dev/mixer, /dev/mixer1 does not
work.
[2.] 
There are two sound cards, first accessible as /dev/dsp, second as
/dev/dsp1. Mixer for first is /dev/mixer, for second should be
/dev/mixer1.. but it doesen't work.
eyck@ghost:~$ aumix -d /dev/mixer1 -r100
aumix:  MIXER_WRITE
eyck@ghost:~$ aumix -d /dev/mixer1 -w100
aumix:  MIXER_WRITE
 At first i thought it's a problem with gus driver, which i've been told
created some problems... but then I switched cards.. now gus is /dev/dsp
and sb is /dev/dsp1. And now I can control my gus, but no longer can
control sb.
[3.] Keywords: sound mixer
[4.] Kernel version: 2.4.18-xfs
[7.] ...irrelevant, probably.
[X.] 
 Who is current SOUND maintainer? Maybe I should switch to ALSA and stop
 bugging ppl?

best regards,
-- 
Eyck, 
 I'm back! And I'm BAD!
...Obviously within certain sensible preset parameters
