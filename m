Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbQJ1UKB>; Sat, 28 Oct 2000 16:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130852AbQJ1UJv>; Sat, 28 Oct 2000 16:09:51 -0400
Received: from laguna.tiscalinet.it ([195.130.224.86]:2297 "EHLO
	laguna.tiscalinet.it") by vger.kernel.org with ESMTP
	id <S130793AbQJ1UJp>; Sat, 28 Oct 2000 16:09:45 -0400
Message-Id: <3.0.1.32.20001028221127.008b6460@pop.tiscalinet.it>
X-Mailer: Windows Eudora Light Version 3.0.1 (32)
Date: Sat, 28 Oct 2000 22:11:27 +0200
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: 2.2.17 & ASUS CD-S500/A (again)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got this while trying to play an audio CD by cdplay.

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "Play Audio TrackIndex" packet command was:
  "48 00 00 00 01 01 00 0a 63 00 00 00 "
hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x54
ATAPI device hdc:
  Error: Illegal request -- (Sense key=0x05)
  Invalid command operation code -- (asc=0x20, ascq=0x00)
  The failed "Play Audio TrackIndex" packet command was:
  "48 00 00 00 01 01 00 0a 01 00 00 00 "
cdplay: ioctl cdromplaytrkind

I can't play any CD under 2.2.17

2.2.17 bug or "Yet Another Bug Of S500/A" ? :-)

NOTE:
2.4.0-test9 works without problems.

--
Lorenzo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
