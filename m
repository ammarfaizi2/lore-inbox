Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276335AbRJKNnp>; Thu, 11 Oct 2001 09:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276339AbRJKNng>; Thu, 11 Oct 2001 09:43:36 -0400
Received: from mail.spylog.com ([194.67.35.220]:44506 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S276335AbRJKNn3>;
	Thu, 11 Oct 2001 09:43:29 -0400
Date: Thu, 11 Oct 2001 17:39:54 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <13522687985.20011011173954@spylog.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.11aa1 and AIC7XXX
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi, folks,

        I see in log next messages:

Oct 10 20:35:31 samson kernel: (scsi0:A:2:0): Locking max tag count at 128
Oct 10 21:06:31 samson kernel: (scsi1:A:0:0): Locking max tag count at 64                                                           
Oct 11 05:33:09 samson kernel: (scsi0:A:3:0): Locking max tag count at 128       

        Hardware   -  SMP 2 CPU, 1GB RAM, M/B Intel L440GX, 5 SCSI HDD, Software
RAID5 (3 disks) and RAID1.

        I found in dmesg:

 *** Possibly defective BIOS detected (irqtable)
 *** Many BIOSes matching this signature have incorrect IRQ routing tables.
 *** If you see IRQ problems, in paticular SCSI resets and hangs at boot
 *** contact your vendor and ask about updates.
 *** Building an SMP kernel may evade the bug some of the time.
Starting kswapd

        It's  normal or not ? What I can do to fix problem with locking max tag
count ?

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

