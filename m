Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130600AbRC0GtW>; Tue, 27 Mar 2001 01:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130618AbRC0GtM>; Tue, 27 Mar 2001 01:49:12 -0500
Received: from mail.n-online.net ([195.30.220.100]:60173 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S130600AbRC0Gsz> convert rfc822-to-8bit; Tue, 27 Mar 2001 01:48:55 -0500
Date: Tue, 27 Mar 2001 08:48:08 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: URGENT : System hands on "Freeing unused kernel memory: "
X-Mailer: Thomas Foerster's registered AK-Mail 3.1 publicbeta2a [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20010327064904Z130600-406+4294@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

i have a realy strange and annyoing problem here.

I have a very busy webserver. Around 2 weeks ago i upgraded from 2.2.18 to 2.4.2-ac20
(SCSI-System, 512 MB RAM, 3 SCSI-Disks, P-III-500). Everything worked fine, the 2.4x Kernel
boosted the box a lot :)

But suddenly the box was offline. One technical assistant from our ISP tried to reboot
our server (he couldn't tell me if there had been any messages on the screen), but the
system always hangs on 

Freeing unused kernel memory: xxk freed

So we took the box home and tried to boot it from a bootdisk (generated as we installed the box,
redhat 7.0). The SAME problem occurs ... 

Freeing unused kernel memory: xxk freed

The system hangs (i've tried 2.2.18 AND 2.4.2-ac20, 2.2.16 is on our bootdisk). I thought
it could be the swap-partition ... so we inserted an IDE Disk, installed a small system so that
i was able to mount the SCSI-Disks. So i rebuild the swap-parition with
mkswap /dev/sda5 and activated it via swapon /dev/sda5 ... worked.

So i tried to boot it again from the SCSI-Disks ... nothing! The same odd failure ...

I've never hat such Problems before .. we've already changed every piece of hardware that's been in the
box (except the disks, but theire looking ok because i can mount them and run e2fsck over it :) )

I need help, because we're already down for 3 Days now. What causes the system to hang at this point??
What must i do the be able to boot the system from the scsi-disks again?

Thanx a lot,
  Thomas

