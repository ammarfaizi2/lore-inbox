Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265925AbRFZGrz>; Tue, 26 Jun 2001 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265926AbRFZGrq>; Tue, 26 Jun 2001 02:47:46 -0400
Received: from mail.ip.eth.net ([202.9.128.18]:15880 "EHLO ip.eth.net")
	by vger.kernel.org with ESMTP id <S265925AbRFZGrf>;
	Tue, 26 Jun 2001 02:47:35 -0400
Date: Tue, 26 Jun 2001 12:18:11 +0530
From: shantanu <shantanu@mail.vu>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
X-Priority: 3 (Normal)
Message-ID: <8512.010626@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: bad file descriptor
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
      i am facing a problem on my Red Hat Linux 6.2 machine. When i
boot in my Linux box it boot properly till it reaches the stage
where it says "Press I for interactive setup"
>From there it starts giving me errors like this : -
Mounting proc file system dup2 : Bad File Descriptor      [FAILED]
Configuring kernel parameters dup2 : Bad File Descriptor      [FAILED]
Loading default keymap/etc/rc.d/rc.sysinit : /dev/null : read only
file system
Activating swap partition dup2 : Bad File Descriptor      [FAILED]
Seting hostname localhost.localdomain : Bad File Descriptor      [FAILED]
Checking root filesystem : Bad File Descriptor      [FAILED]

An error occured during file system check
For maintance mode give password [ctrl-d for normal setup]


when I give root password i can log in as single user and it gives
this message the moment I log in:

bash: /dev/null :Read only file system
kcd : cannot create file /root/.kcd.newdir
Broken pipe.

When i press ctrl-D for normal login the machine reboots.
I tried running fsck, e2fsck, checked for bad blocks and made force
checking too. still the problem is not solved.
This system was running perfectly for 6-7 months.
Please help.
thanks in advance and waiting for the reply.
-- 
Best regards,
 shantanu                          mailto:shantanu@mail.vu


