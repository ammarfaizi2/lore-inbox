Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287361AbRL3Ivi>; Sun, 30 Dec 2001 03:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287362AbRL3Iv1>; Sun, 30 Dec 2001 03:51:27 -0500
Received: from TheForce.com.au ([203.18.20.200]:16141 "EHLO
	ob1.theforce.com.au") by vger.kernel.org with ESMTP
	id <S287361AbRL3IvO>; Sun, 30 Dec 2001 03:51:14 -0500
Subject: VCD/XA files not reading
From: Grahame Jordan <gbj@theforce.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 30 Dec 2001 19:51:02 +1100
Message-Id: <1009702262.2223.32.camel@falcon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a video cd that mounts OK and reads the smaller files, but when I
try to read the mpeg file (avseq01.dat) it fails.  There seems to be
support for XA in include/linux/cdrom.h but it's not working for me.  I
downloaded the same file to my HDD and it works fine.

Kernel 2.4.16
CDROM: Pioneer DVD-116


When using:
cp avseq01.dat /var/tmp
cp: reading `avseq01.dat': Input/output error


dmesg gives:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1920
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1924
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1928
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1932
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1936
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1940
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1944
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x50
end_request: I/O error, dev 16:00 (hdc), sector 1948


Thanks

-- 
Grahame Jordan
TheForce

