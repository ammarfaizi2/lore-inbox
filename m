Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275423AbTHIWMv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 18:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275424AbTHIWMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 18:12:51 -0400
Received: from bgp01116707bgs.westln01.mi.comcast.net ([68.42.104.61]:2052
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id S275423AbTHIWMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 18:12:47 -0400
Message-ID: <3F356881.9070206@blackmagik.dynup.net>
Date: Sat, 09 Aug 2003 17:32:49 -0400
From: Eric Blade <eblade@blackmagik.dynup.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2/3 ESS1371 Audio
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.0-test1, the ESS1371 module stopped giving me sound output when 
compiled into the kernel, but worked as a module.

In 2.6.0-test2, the module completely stopped giving me sound output as 
well.

In 2.6.0-test3, the modules refuse to insmod.

I get the following during depmod during 'make modules_install':
 
 depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/net/hamachi.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/drivers/net/yellowfin.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/oss/snd-mixer-oss.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/oss/snd-pcm-oss.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/oss/snd-seq-oss.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-device.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-midi-event.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq-midi.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/seq/snd-seq.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-pcm.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-rawmidi.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-rtctimer.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd-timer.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/core/snd.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/pci/ac97/snd-ac97-codec.ko
depmod: *** Unresolved symbols in 
/lib/modules/2.6.0-test3/kernel/sound/pci/snd-ens1371.ko


  .. I noticed there were lots of patches in the sound directory... is 
there something I missed?

-- 
----BEGIN GEEK CODE BLOCK----
Version: 3.1
GB/CS/MC/MU/O @d+ s:- a- C++++ UL++++  !P  L+++ !E W+++ !N !o K? w--- @O++ !M !V PS+ PE- Y PGP- @t 5? X R tv-- b- DI++ D++ G e* h* r  y+ 
----END GEEK CODE BLOCK----




