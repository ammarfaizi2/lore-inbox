Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273748AbRIRUnK>; Tue, 18 Sep 2001 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273910AbRIRUnB>; Tue, 18 Sep 2001 16:43:01 -0400
Received: from [194.213.32.137] ([194.213.32.137]:28420 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273748AbRIRUmx>;
	Tue, 18 Sep 2001 16:42:53 -0400
Message-ID: <20010918115212.A186@bug.ucw.cz>
Date: Tue, 18 Sep 2001 11:52:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: blocksize problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After trying

mount /dev/hda2 /mnt -tvfat (failed, its swap partition)
mkswap /dev/hda2
swapon /dev/hda2

reboot fails, complaining about blocksize ("Only 4096 blocks
implemented (512)"). (Oh, maybe there's umount /dev/hda2 in reboot
scripts...).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
