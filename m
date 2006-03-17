Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWCQOgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWCQOgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWCQOgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:36:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37382 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750758AbWCQOgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:36:44 -0500
Date: Fri, 17 Mar 2006 15:36:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>, norsk5@xmission.com, dsp@llnl.gov,
       bluesmoke-devel@lists.sourceforge.net,
       Tom Seeley <redhat@tomseeley.co.uk>, Jiri Slaby <jirislaby@gmail.com>,
       v4l-dvb-maintainer@linuxtv.org, gregkh@suse.de,
       Avuton Olrich <avuton@gmail.com>, Nathan Scott <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, Parag Warudkar <kernel-stuff@comcast.net>,
       Takashi Iwai <tiwai@suse.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, Alex Outhred <aouthred@gmail.com>,
       NeilBrown <neilb@suse.de>
Subject: 2.6.16-rc6: known regressions (v2)
Message-ID: <20060317143642.GJ3914@stusta.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you was declared guilty for a breakage or I'm considering you in any
other way possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : signal_cache slab corruption
References : http://lkml.org/lkml/2006/3/13/170
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : edac slab corruption
References : http://lkml.org/lkml/2006/3/5/14
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : yet more slab corruption
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184310
Submitter  : Dave Jones <davej@redhat.com>
Status     : unknown


Subject    : wintv-novaT broken (no devices in in /dev/dvb)
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
             http://lkml.org/lkml/2006/2/18/204
Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
             Dave Jones <davej@redhat.com>
Handled-By : Jiri Slaby <jirislaby@gmail.com>
Status     : submitter tries to bisect to find the guilty change


Subject    : XFS oopses on my box sometimes
References : http://bugzilla.kernel.org/show_bug.cgi?id=6180
Submitter  : Avuton Olrich <avuton@gmail.com>
Handled-By : Nathan Scott <nathans@sgi.com>
Status     : discussion in the bug


Subject    : snd-intel-hda stopped working on a Dell E1705 Laptop
References : http://lkml.org/lkml/2006/3/12/16
Submitter  : Parag Warudkar <kernel-stuff@comcast.net>
Handled-By : Takashi Iwai <tiwai@suse.de>
Status     : Takashi Iwai: This looks like a problem of the latest sigmatel
                           codec code in general. The author of original
                           code is investigating.


Subject    : The init process gets stuck in "D" state during boot.
References : http://bugzilla.kernel.org/show_bug.cgi?id=6230
Submitter  : Alex Outhred <aouthred@gmail.com>
Handled-By : NeilBrown <neilb@suse.de>
Status     : guilty commit: 04b857f74cec5efc7730e9db47e291310f4708a4


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

