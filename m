Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAPSU6>; Tue, 16 Jan 2001 13:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRAPSUs>; Tue, 16 Jan 2001 13:20:48 -0500
Received: from nic.lth.se ([130.235.20.3]:42687 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S129401AbRAPSUo>;
	Tue, 16 Jan 2001 13:20:44 -0500
Date: Tue, 16 Jan 2001 19:20:42 +0100
From: Jakob Borg <jakob@borg.pp.se>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG with 2.4.1-pre7 reiserfs
Message-ID: <20010116192041.A466@borg.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux narayan 2.4.1-pre7 i686 SMP 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently got this in my logs after moving /home to reiserfs. It is a plain
2.4.1-pre7 SMP system (.config attached).

Jan 16 19:15:02 narayan kernel: journal_begin called without kernel lock held
Jan 16 19:15:02 narayan kernel: kernel BUG at journal.c:423!
Jan 16 19:15:02 narayan kernel: CPU:   0

I seem to remember more possibly useful information scrolling by my screen,
but it seems to not have made it to the logs, and I will shut down and fsck
the filesystem now...

Regards,

-- 
Jakob Borg            mailto:jakob@borg.pp.se       (personal)
UNIX/network admin    mailto:jakob@debian.org    (development)
systems programmer    mailto:jakob@morotsmedia.se       (work)
                      http://jakob.borg.pp.se/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
