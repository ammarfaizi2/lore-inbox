Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265729AbRF1NWo>; Thu, 28 Jun 2001 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbRF1NWg>; Thu, 28 Jun 2001 09:22:36 -0400
Received: from ns1.n-online.net ([195.30.220.100]:64015 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S265729AbRF1NWZ>; Thu, 28 Jun 2001 09:22:25 -0400
Date: Thu, 28 Jun 2001 15:19:24 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: SMP-Board, only 1 CPU, strange Crashes
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010628132231Z265729-17720+8653@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

i have a Dual-PCU-Board but only one CPU is plugged in.
I've compiled the kernel without SMP.

Now the system runs fine for about 1 Week. After than, it oftens "crashes".
"crashes" is not realy the thing ... diffrent things happen :

* The whole system hangs WIHTOUT any kernel-message on the screen or in the logfiles,
  i still can ping the system
* A lot of processes dieing, system is pingable, reboot with ctrl-alt-del works
* All processes are in state "Z", login is still possible

and so on ...

After the reboot, e2fsck needs to fix a lot of things (ext2 issue...).

The system is running on 2.4.4-ac18

lspci says :

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RL


The main use of the box is to serve webpages with apache+php, ftp and ssh, not too busy
(load is about 0.1<->1). Ide drives are absent.

Whats happending to this box? I've never had such problems. Is it because of the
Dual-Board and the non-smp kernel? (i need to know this, because we can't tolerate any more
downtime right now)

Thanks,
  Thomas

