Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266418AbRGHD2T>; Sat, 7 Jul 2001 23:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266419AbRGHD2J>; Sat, 7 Jul 2001 23:28:09 -0400
Received: from vmail1.wmis.net ([216.109.195.1]:25353 "EHLO vmail1.wmis.net")
	by vger.kernel.org with ESMTP id <S266418AbRGHD2A>;
	Sat, 7 Jul 2001 23:28:00 -0400
From: Rick Hayner <rhayner@complink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15175.54038.760468.100479@rhayner.selfhost.com>
Date: Sat, 7 Jul 2001 23:27:18 -0400
To: linux-kernel@vger.kernel.org
Subject: trying again.
X-Mailer: VM 6.92 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello to all.

I'm sorry if this is the wrong list to post this question to, but I
did 4 days ago, and haven't seen anything concerning my problem.

I have a Ricoh mp7120a cdrw drive.  Since it is a atapi drive, i must
use ide-scsi and sg to use it with cdrecord.  However there is a
strange problem with the audio cd players.  After issuing a command to
stop an audio cd from playing, two play commands are required to start
the cd playing again.  This doesn't happen if I use the ide-cd driver,
and point /dev/cdrom to /dev/hdc.

There is no documentation at all on ide-scsi, and I can't find any
error messages anywhere.  I have the following append command in
lilo.conf
append="hdc=ide-scsi"

If someone is working on this, or has any idea as to what's happening,
I would sure appreciate it.   I am using kernel version 2.2.19.  this
also occurred with 2.2.18.  the audio cd players return no error
messages at all.  when the first play command is issued after a stop
command, I just get the shell prompt back with nothing happening to
the cd-rw drive at all, until I ether open and close the drive, or
issue a second play command.  If I open and close the drive between
stop and play commands, it plays the cd every time.

Thanks.

-- 
Rick Hayner
rhayner@complink.net
Member spebsqsa, Baritone Kalamazoo Mall City Chorus.
Amateur radio station wa8jqv
