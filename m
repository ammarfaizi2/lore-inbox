Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRCEINl>; Mon, 5 Mar 2001 03:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRCEINb>; Mon, 5 Mar 2001 03:13:31 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129137AbRCEINV>;
	Mon, 5 Mar 2001 03:13:21 -0500
Message-ID: <20010305091313.A138@bug.ucw.cz>
Date: Mon, 5 Mar 2001 09:13:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.2 broke in-kernel ide_cs support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I do not yet know details, but it worked in 2.4.1 and it does not work
now:

Mar  5 09:12:05 bug cardmgr[69]: initializing socket 1
Mar  5 09:12:05 bug cardmgr[69]: socket 1: ATA/IDE Fixed Disk
Mar  5 09:12:05 bug cardmgr[69]: module //pcmcia/ide_cs.o not
available
Mar  5 09:12:06 bug cardmgr[69]: get dev info on socket 1 failed:
Resource temporarily unavailable
								Pavel
((Module not available is okay, it should be compiled into kernel))
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
