Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264589AbTCZD3u>; Tue, 25 Mar 2003 22:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264578AbTCZD2M>; Tue, 25 Mar 2003 22:28:12 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:58766 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264577AbTCZD1m>;
	Tue, 25 Mar 2003 22:27:42 -0500
Date: Tue, 25 Mar 2003 22:41:31 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: OSS Status
Message-ID: <20030325224131.GE607@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I understand that OSS may be included in 2.6, and therefore, I would like
to help update it.

Major Issues Include the following:
1.) OSS is not in sync with 2.4
2.) Locking is horribly broken in some areas
3.) Many Drivers are not using the new 2.5 APIs

For easy merging, I would like to focus on the first issue.

The following is a rough estimate of where the 2.4 changes in 2.5 OSS code
stand.  These results were derived from a diff between 2.4.17 and 2.4.21-pre5.
Some may be incorrect but, for the most part, this represents the situation.

I will be hosting an OSS bk tree (bk://linux-pnp.bkbits.net/oss-2.5), so
anyone interested in assisting with this effort, please contact me.  Also
Any comments would be appreciated.

Thanks,
Adam

against 2.5.65 (some of these may be in 2.5.66 especially emu10k1)

fail: (Mostly Rejects)
1.) Config files
2.) Makefile
3.) ad1848.c
4.) awe_wave.c
5.) cs4281pm-24.c
6.) dmasound/dmasound_atari.c
7.) dmasound_awacs.c
8.) dmasound/dmasound_paula.c
9.) ite8172.c
10.)rme96xx.c
11.)sb_card.c
12.)trident.c

done already: (anything with the "previously applied" warning, accurate?)
1.) ac97_codec.c
2.) aedsp16.c
3.) btaudio.c
4.) cmpci.c
5.) cs4232.h
6.) cs4281_wrapper-24.c
7.) dmasound_core.c
8.) es1370.c
9.) es1371.c
10.)esssolol.c
11.)gus.h
12.)i810_audio.c
13.)maestro3.c
14.)mpu401.c
15.)mpu401.h
16.)nec_vrc5477.c
17.)nm256_audio.c
18.)opl3.h
19.)pas2.h
20.)pss.c
21.)rme96xx.h
22.)sb_audio.c
23.)sb_common.c
24.)sonicvibes.c
25.)sound_config.h
26.)trident.h
27.)vwsnd.c
28.)ymfpci.c
29.)ymfpci.h

clean: (no rejects or small amounts of fuzz)
1.) ad1889.h
2.) ali5455.c
3.) au1000.c
4.) bin2hex.c
5.) cs4281_wrapper.h
6.) cs4281pm-24.h
7.) dmasound/awacs_defs.h
8.) dmasound/dac3550a.c
9.) dmasound/dmasound.h
10.)dmasound/tas3001c.c
11.)dmasound/tas3001c.h
12.)dmasound/trans_16.c
13.)emu10k1/audio.c
14.)emu10k1/audo.h
15.)emu10k1/cardwi.c
16.)emu10k1/cardwi.h
17.)emu10k1/cardwo.h
18.)emu10k1/efxmgr.c
19.)emu10k1/efxmgr.h
20.)emu10k1/hwaccess.c
21.)emu10k1/hwaccess.h
22.)emu10k1/irqmgr.c
23.)emu10k1/main.c
24.)emu10k1/midi.c
25.)emu10k1/mixer.c
26.)emu10k1/recmgr.c
27.)emu10k1/recmgr.h
28.)emu10k1/timer.c
29.)emu10k1/timer.h
30.)emu10k1/voicemgr.c
31.)emu10k1/voicemgr.h
32.)forte.c
33.)hal2.c
34.)hal2.h
35.)harmony.c
36.)sb_mixer.c
37.)swarm_cs4297a.c

* please note that although these changes are clean, they may not
necessarily compile.  Investigation is needed.

partially clean: (a small amount of rejects and/or large fuzz)
1.) awe_wave.c
2.) cs4232.c
3.) cs4281m.c
4.) cs46xx.c
5.) dmasound/dmasound_q40.c
6.) emu10k1/cardwo.c
7.) midibuf.c
8.) msnd_pinnacle.c
9.) opl3sa2.c
10.)via82cxxx_audio.c


