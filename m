Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129321AbRBXGvX>; Sat, 24 Feb 2001 01:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129332AbRBXGvN>; Sat, 24 Feb 2001 01:51:13 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:9187 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129321AbRBXGvB>; Sat, 24 Feb 2001 01:51:01 -0500
Date: Fri, 23 Feb 2001 22:48:08 -0800
From: Jon Hart <wedogs@pacbell.net>
Subject: PROBLEM: loopback block device freezes mount
To: linux-kernel@vger.kernel.org
Reply-to: jonhart_99@yahoo.com
Message-id: <3A975928.D758949F@pacbell.net>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-jah01 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Per /usr/src/linux/REPORTING-BUGS...

1. I am unable to mount loopback block devices using kernel 2.4.2.

2. Using the 2.4.2 kernel, the mount command freezes while trying to
mount
/dev/loop0.  Further, the mount command will not die even with kill -9.

I have not experienced this problem in kernel 2.4.1 and below; however,
I did
experience the problem with 2.4.2-pre4.

3. Keywords: loopback block mount

4. /proc/version
Linux version 2.4.2-jah01 (root@diana.wedogs.org)
(gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release))
#2 Fri Feb 23 21:54:34 PST 2001

5. No Oops.. message

6. The specific command I'm using is...
mount -t iso9660 -oro,loop=/dev/loop0 /mnt/cdrom /apath/animage.iso

On my system, the above command will hang until reboot.  I can change
virtual terminals etc.  However, after the above command is issued, no
filesystems can be mounted/unmounted until the system is restarted
(even the shutdown hangs while trying to unmount all filesystems).

7. No modules loaded (e.g. loopback, nic, sound compiled directly into
the kernel).

Thanks for your help.  Please let me know if you need any additional
information.

--
=-=-=-=-=-=-=-=-=-=-=-=-=
Jonathan Hart
=-=-=-=-=-=-=-=-=-=-=-=-=



