Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276738AbRJPVXv>; Tue, 16 Oct 2001 17:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276737AbRJPVXl>; Tue, 16 Oct 2001 17:23:41 -0400
Received: from atlrel7.hp.com ([192.151.27.9]:41737 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S276736AbRJPVX0>;
	Tue, 16 Oct 2001 17:23:26 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D570@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Cc: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: Problem with 2.4.14prex and qlogicfc
Date: Tue, 16 Oct 2001 17:23:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I'm seeing a problem on all the kernels that are 2.4.13pre1 and up.  I've
lost the ability to communicate to my storage through some qlogic 2200 fibre
channel cards.  All the disks are identified and given over to devices. The
problem occurs when you attempt to write to the disks.  The system prints
out that the link is up, but will not move from there.  The system becomes
unresponsive to the keyboard.  Up to 2.4.12 works ok (I'm putting together
some comparative numbers), and the current ac tree is working correctly as
well.

I saw this behavior with 2.4.10 and the bounce memory patch by Jens Axboe,
but attributed it to operator error.  I'm less sure now. 

Any ideas about what is going on would be appreciated.  I know this is a
sketchy description, but I'm hoping someone else has seen it too and can
help me get closer to a resolution.

Cary Dickens
Hewlett-Packard


Hardware:
4 processors, 4GB ram
45 fibre channel drives, set up in hardware RAID 0/1
2 direct Gigabit Ethernet connections between SPEC SFS prime client and
system under test
reiserfs
all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes to
storage
NFS v3 UDP

