Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAPNlN>; Tue, 16 Jan 2001 08:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRAPNlD>; Tue, 16 Jan 2001 08:41:03 -0500
Received: from lca0042.lss.emc.com ([168.159.120.42]:37264 "EHLO
	lca0042.lss.emc.com") by vger.kernel.org with ESMTP
	id <S129401AbRAPNkx>; Tue, 16 Jan 2001 08:40:53 -0500
To: linux-kernel@vger.kernel.org
Subject: problem mounting root under 2.4.0
From: Chris Jones <clj@emc.com>
Date: 16 Jan 2001 08:40:41 -0500
Message-ID: <hp4ryzk42u.fsf@lca2240.lss.emc.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm unable to boot a 2.4.0 kernel on a system that's been running 2.2.18.  It
fails early in boot with the following messages:

request-module[block-major-8]: Root fs not mounted
VFS: Cannot open root device "801" or 08:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 08:01

I suspect the problem is related to loading the aic7xxx.o module, but the
relevant messages have scrolled off the top of the screen.  I tried setting the
VGA mode to extended to give me 50 lines of output, but even though "lilo -q
-v" shows "VGA mode: EXTENDED", I still have a 25 line screen.  CTRL-Alt-DEL
doesn't work, so I have to power-cycle the machine, so I lose any messages that
are saved in memory.  Is there a way I can get the equivalent of "more" breaks
on boot so I have a chance to read the messages?

I have upgraded to modutils 2.4.1 and mkinitrd 2.5.  Are there some gotchas I
should be aware of?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
