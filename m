Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSHTKp1>; Tue, 20 Aug 2002 06:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSHTKp1>; Tue, 20 Aug 2002 06:45:27 -0400
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:10255 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S316795AbSHTKp1>;
	Tue, 20 Aug 2002 06:45:27 -0400
Subject: 2.4.20-pre{2-4} boot problems
From: Sid Boyce <sboyce@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Aug 2002 10:49:30 +0000
Message-Id: <1029840571.2211.15.camel@barrabas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting any of the above (including -ac), I get the following
message, 2.4.20-pre1-ac1 is what is currently running fine and the only
pre1 kernel I've tried. I have reiserfs compiled in, same .config for
all kernels.

Freeing initrd memory: 466K freed
VFS: Mounted root (ext2 filesystem) kmod  failed to exec /sbin/modprobe
-s -k block-major-3, errno = 2
VFS Cannot open root device "306" or 03:06
Please append a correct "root=" boot option
Kernel panic. VFS: Unable to mount rootfs on 03:06
----------------------------------------------------
	I have checked the Changelog and I'm at or above the recommended
levels. I've tried bot gcc-2.95.3 and gcc-3.0.4 with same results.
------------------------------------------------------------------

barrabas:/home/lancelot # uname -r;mount
2.4.20-pre1-ac1
/dev/hda6 on / type reiserfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
/dev/hda1 on /boot type ext2 (rw)
/dev/hdc1 on /usr1 type reiserfs (rw)
/dev/sda1 on /data1 type reiserfs (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw,devmode=0666)
shmfs on /dev/shm type shm (rw)
===================================================================
mount: mount-2.11n

Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

