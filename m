Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTLLHgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 02:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTLLHgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 02:36:13 -0500
Received: from [62.12.131.37] ([62.12.131.37]:1952 "HELO debian")
	by vger.kernel.org with SMTP id S264499AbTLLHgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 02:36:11 -0500
Date: Fri, 12 Dec 2003 08:36:09 +0100
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: linux-kernel@vger.kernel.org
Subject: alsa on gentoo ppc 2.6.0-test11-benh1
Message-Id: <20031212083609.6db56e5b.zdavatz@ywesee.com>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List

I got two questions:
1.
I am running alsa on gentoo ppc 2.6.0-test11-benh1.
I done my kernel with make menuconfig, make, make modules_install

lsmod gives me:
snd_seq_oss            41720  0
snd_seq_midi_event      8992  1 snd_seq_oss
snd_seq                64024  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          9924  2 snd_seq_oss,snd_seq
snd_pcm_oss            69188  0
snd_pcm               123700  1 snd_pcm_oss
snd_page_alloc         14052  1 snd_pcm
snd_timer              28608  2 snd_seq,snd_pcm
snd_mixer_oss          22464  1 snd_pcm_oss
snd                    66340  8 snd_seq_oss,snd_seq_midi_event,snd_seq,snd_seq_device,snd_pcm_oss,snd_pcm,snd_timer,snd_mixer_oss
dmasound_pmac          89752  1
dmasound_core          22188  2 dmasound_pmac
i2c_core               29540  1 dmasound_pmac
soundcore              11200  3 snd,dmasound_core

When I do amixer I get:
amixer: Mixer attach default error: No such device

I done my kernel with make menuconfig, make, make modules_install

I have been searching the Net for clues but did not find anything so far, to get my sound working.

alsasound restart gives me:
 * WARNING:  you are stopping a boot service.
 * Unloading ALSA...
 * Storing ALSA Mixer Levels
/usr/sbin/alsactl: save_state:1061: No soundcards found...
 * Unloading modules                                                                                                                                       [ ok ] * Loading ALSA drivers...
 * Loading: snd-mixer-oss
 * Loading: snd-pcm-oss
 * Loading: snd-seq-oss
 * Loading: snd-powermac
FATAL: Error inserting snd_powermac (/lib/modules/2.6.0-test11-benh1/kernel/sound/ppc/snd-powermac.ko): No such device
 * Loading: snd-seq-oss
FATAL: Module snd_seq_oss already in kernel.
 * Running card-dependent scripts
 * Restoring Mixer Levels 

2. Why does my computer go to sleep when I press 'CapsLook'. Can I turn that off or is this still a 2.6.0 Bug?

Thanks for any help and hints.
Zeno
-- 
Mit freundlichen Grüssen / best regards

Zeno Davatz
Verkauf & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.oddb.org
