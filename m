Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268495AbTBWRml>; Sun, 23 Feb 2003 12:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268518AbTBWRml>; Sun, 23 Feb 2003 12:42:41 -0500
Received: from mail.ithnet.com ([217.64.64.8]:40461 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S268495AbTBWRmk>;
	Sun, 23 Feb 2003 12:42:40 -0500
Date: Sun, 23 Feb 2003 18:52:44 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with IDE-SCSI in 2.4.21-pre4/2.4.20
Message-Id: <20030223185244.3252261b.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am experiencing a weird problem with ide-scsi. I try to do a simple CD mount
with above kernel versions. This results in spinning up cdrom drive, then
increasing cpu load and about 1 minute after that a complete freeze of the
system. To be honest I am not really sure if I am doing something wrong, but
cannot image what that could be.
I tried simple "mount /dev/sr0 /mnt" -> spinup, then freeze, "mount /dev/scd0
/mnt" -> spinup, then freeze. I even tried attaching a real SCSI cdrom, which
works as expected. I tried booting a live filesystem directly from the
questionable drive, it works (obviously does not use ide-scsi, but atapi). I
tried another ATAPI cdrom (first acer, then LiteOn), freeze. So it is no
hardware problem.
After beating this unbelievable problem for 5 hours I am now out-of-ideas. 
Any hints welcome.

-- 
Regards,
Stephan
