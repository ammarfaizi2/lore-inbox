Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313098AbSDDDAn>; Wed, 3 Apr 2002 22:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313103AbSDDDAd>; Wed, 3 Apr 2002 22:00:33 -0500
Received: from lucy.ulatina.ac.cr ([163.178.60.3]:27655 "EHLO
	lucy.ulatina.ac.cr") by vger.kernel.org with ESMTP
	id <S313098AbSDDDAW>; Wed, 3 Apr 2002 22:00:22 -0500
Subject: "Disk Sleep" status on qlogic scsi sbus card on a sparc station 20
	(sparc32, 2.4.17)
From: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 03 Apr 2002 20:57:24 -0600
Message-Id: <1017889044.221.10.camel@lucy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know sparc32 is not mantained any more, but I'm still posting in case
this problem with give light to a problem that might apear on another
arquitecture.

I'm running kernel 2.4.17 on a sparc station 20 (with 2 procesors)
running splack -current.

I have a scsi qlogic sbus card on this box on with I attatch an scsi
tape or a multipack storage with some 8 to 12 disks on it.

While I run diferent aplications (not at a time) that are some I/O
intensive on the devices attatched to this qlogic card and I sometimes
see some huge sleeps on the process that is working on them.

I cat'ed /proc/{PID}/status and I see "State:  D (disk sleep)".

Sometimes the process goes on working, but not often. I also can't send
this process to sleep nor I can kill them.

I have used tar to back up an filesystem to a DD3 tape, and have also
used rsync from another host (On a 100Mb LAN) to a raid formed by the
disks that are attatched to the controller.

BTW, this does *NOT* occur on an ultra1 box (which is sparc64) running
the same kernel version, and with the same set of disk or the same tape
with the same qlogic scsi sbus card.

What test could I run on this box to give some more information to you
guys that would help to resolve this problem?

Or else, what could be that problem, and what could I do to solve it?

Thanks in advance.

-- 
Alvaro Figueroa

