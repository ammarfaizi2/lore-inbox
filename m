Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283141AbRK2KUT>; Thu, 29 Nov 2001 05:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283135AbRK2KUK>; Thu, 29 Nov 2001 05:20:10 -0500
Received: from [151.17.201.167] ([151.17.201.167]:17673 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S283138AbRK2KTw>;
	Thu, 29 Nov 2001 05:19:52 -0500
Message-ID: <3C060A83.45DC8CDC@teamfab.it>
Date: Thu, 29 Nov 2001 11:14:27 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: "spurious 8259A interrupt: IRQ7"
In-Reply-To: <3511.10.119.8.1.1006856832.squirrel@extranet.jtrix.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my "old" system this message appear randomly after the boot process
when my machine always try to make a ISDN connection with my provider.
Sometimes appears in the kernel boot process... funny.

IOAPIC : not set
kernel : 2.4.x
CPU    : K6-2 450
Chipset: 

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev b4)
00:08.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
00:09.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 04)
00:0a.0 Multimedia audio controller: Trident Microsystems 4DWave DX (rev 02)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Productiva] AGP (rev 02)


grep -A1 -B1 spurious /var/log/messages :

May 12 10:04:05 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
May 12 10:04:44 localhost kernel: spurious 8259A interrupt: IRQ7.
May 12 10:04:44 localhost ipppd[529]: Modem hangup
--
May 23 21:10:33 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
May 23 21:28:29 localhost kernel: spurious 8259A interrupt: IRQ7.
May 23 21:49:49 localhost -- MARK --
--
May 30 20:15:57 localhost -- MARK --
May 30 20:16:31 localhost kernel: spurious 8259A interrupt: IRQ7.
May 30 20:35:57 localhost -- MARK --
--
Jun  9 15:16:37 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
Jun  9 15:16:42 localhost kernel: spurious 8259A interrupt: IRQ7.
Jun  9 15:17:28 localhost ipppd[529]: Modem hangup
--
Jun 25 19:01:16 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
Jun 25 19:01:20 localhost kernel: spurious 8259A interrupt: IRQ7.
Jun 25 19:02:06 localhost ipppd[529]: Modem hangup
--
Jun 28 05:33:12 localhost ipppd[529]: remote IP address XXX.YYY.XXX.59
Jun 28 05:36:02 localhost kernel: spurious 8259A interrupt: IRQ7.
Jun 28 05:36:30 localhost ipppd[529]: Modem hangup
--
Jul  3 21:33:19 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
Jul  3 21:33:30 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul  3 21:39:04 localhost ipppd[529]: Modem hangup
--
Jul  5 07:31:04 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
Jul  5 07:32:22 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul  5 07:38:02 localhost ipppd[529]: Modem hangup
--
Jul  9 23:18:48 localhost Wmaker: Hi luca, welcome to localhost
Jul  9 23:24:02 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul  9 23:38:25 localhost -- MARK --
--
Jul 12 22:11:20 localhost -- MARK --
Jul 12 22:22:53 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 12 22:51:20 localhost -- MARK --
--
Jul 15 22:21:34 localhost ipppd[529]: remote IP address XXX.YYY.XXX.54
Jul 15 22:21:39 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 15 22:22:07 localhost ipppd[529]: Modem hangup
--
Jul 16 21:26:53 localhost ipppd[530]: remote IP address XXX.YYY.XXX.54
Jul 16 21:26:58 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 16 21:30:24 localhost ipppd[530]: Modem hangup
--
Jul 17 20:11:57 localhost ipppd[530]: Connect[0]: /dev/ippp0, fd: 7
Jul 17 20:13:45 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 17 20:13:53 localhost Wmaker: Hi luca, welcome to luca.home.net
--
Jul 23 20:08:51 localhost kernel: loop: loaded (max 8 devices)
Jul 23 20:14:38 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 23 20:25:42 localhost -- MARK --
--
Jul 25 19:21:29 localhost ipppd[530]: remote IP address XXX.YYY.XXX.59
Jul 25 19:22:03 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 25 19:22:03 localhost ipppd[530]: Modem hangup
--
Jul 26 07:55:53 localhost -- MARK --
Jul 26 07:57:43 localhost kernel: spurious 8259A interrupt: IRQ7.
Jul 26 08:09:42 localhost init: Switching to runlevel: 6
--
Aug 14 17:41:53 localhost kernel: HiSax: Approved with Eicon Technology Diva 2.01 PCI cards
Aug 14 17:41:53 localhost kernel: spurious 8259A interrupt: IRQ7.
Aug 14 17:41:53 localhost kernel: HiSax: Approved with Sedlbauer Speedfax + cards
--
Aug 22 08:49:40 localhost kernel: Adding Swap: 264592k swap-space (priority -1)
Aug 22 08:49:40 localhost kernel: spurious 8259A interrupt: IRQ7.
Aug 22 08:49:41 localhost cron[439]: (CRON) STARTUP (fork
ok)                                                                                           
--                                                                                                                                                      
Nov 10 10:28:15 localhost lircd-0.6.4[576]: caught
signal                                                                                               
Nov 10 10:31:08 localhost kernel: spurious 8259A interrupt:
IRQ7.                                                                                       
Nov 10 10:42:00 localhost CRON[743]: (root) CMD ([ -x /usr/sbin/cronloop ] && /usr/sbin/cronloop Hourly)
