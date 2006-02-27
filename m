Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWB0GN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWB0GN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWB0GN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:13:57 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13843 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751060AbWB0GNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:13:55 -0500
Date: Mon, 27 Feb 2006 07:13:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tom Seeley <redhat@tomseeley.co.uk>, Dave Jones <davej@redhat.com>,
       Jiri Slaby <jirislaby@gmail.com>, michael@mihu.de,
       mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com, Brian Marete <bgmarete@gmail.com>,
       Ryan Phillips <rphillips@gentoo.org>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>, Luming Yu <luming.yu@intel.com>,
       len.brown@intel.com, linux-acpi@vger.kernel.org,
       Mark Lord <lkml@rtr.ca>, Randy Dunlap <rdunlap@xenotime.net>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       Duncan <1i5t5.duncan@cox.net>, Pavlik Vojtech <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, Meelis Roos <mroos@linux.ee>
Subject: 2.6.16-rc5: known regressions
Message-ID: <20060227061354.GO3674@stusta.de>
Reply-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.16-rc5 compared to 2.6.15.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you was declared guilty for a breakage or I'm considering you in any
other way possibly involved with one or more of these issues.

Due to the huge amount of recipients, this email has a Reply-To set.
Please add the appropriate people to the Cc when replying regarding one 
of these issues.


Subject    : usb_submit_urb(ctrl) failed on 2.6.16-rc4-git10 kernel
References : http://bugzilla.kernel.org/show_bug.cgi?id=6134
Submitter  : Ryan Phillips <rphillips@gentoo.org>
Status     : unknown


Subject    : Oops in Kernel 2.6.16-rc4 on Modprobe of saa7134.ko
References : http://lkml.org/lkml/2006/2/20/122
Submitter  : Brian Marete <bgmarete@gmail.com>
Status     : unknown


Subject    : saa7146: no devices created in /dev/dvb
References : https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
             http://lkml.org/lkml/2006/2/18/204
Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
             Dave Jones <davej@redhat.com>
Handled-By : Jiri Slaby <jirislaby@gmail.com>
Status     : unknown


Subject    : S3 sleep hangs the second time - 600X
References : http://bugzilla.kernel.org/show_bug.cgi?id=5989
Submitter  : Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Handled-By : Luming Yu <luming.yu@intel.com>
Status     : is being debugged,
             we might want to change the default back for 2.6.16:
             http://lkml.org/lkml/2006/2/25/101


Subject    : 2.6.16-rc[34]: resume-from-RAM unreliable (SATA)
References : http://lkml.org/lkml/2006/2/20/159
Submitter  : Mark Lord <lkml@rtr.ca>
Handled-By : Randy Dunlap <rdunlap@xenotime.net>
Status     : one of Randy's patches seems to fix it


Subject    : total ps2 keyboard lockup from boot
References : http://bugzilla.kernel.org/show_bug.cgi?id=6130
Submitter  : Duncan <1i5t5.duncan@cox.net>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
             Pavlik Vojtech <vojtech@suse.cz>
Status     : discussion and debugging in the bug logs


Subject    : psmouse starts losing sync in 2.6.16-rc2
References : http://lkml.org/lkml/2006/2/5/50
Submitter  : Meelis Roos <mroos@linux.ee>
Handled-By : Dmitry Torokhov <dmitry.torokhov@gmail.com>
Status     : Dmitry: Working on various manifestations of this one.
                     At worst we will have to disable resync by default
                     before 2.6.16 final is out and continue in 2.6.17 cycle.



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

