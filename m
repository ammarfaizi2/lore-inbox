Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264132AbRFSLCS>; Tue, 19 Jun 2001 07:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264141AbRFSLCI>; Tue, 19 Jun 2001 07:02:08 -0400
Received: from [213.236.192.200] ([213.236.192.200]:36236 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S264132AbRFSLBt>; Tue, 19 Jun 2001 07:01:49 -0400
Message-ID: <05fd01c0f8af$1d1a4500$d2c0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.20_heb2.08.0106191305060.1005-100000@pomela2.cs.huji.ac.il>
Subject: Scsi
Date: Tue, 19 Jun 2001 13:00:52 +0200
Organization: CircleStorm Productions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached below: original mail to the 'linux-scsi' list
Please read attachment first.

It seems that the Davicom NIC's is the problem in this system.
I have tried to swap them with new davicom cards, and tried
with only one of them.

Davicom DM9102AF is the chip on all the cards.
Adaptec SCSI 19160 Ultra160, 68/50pin  (7892B, rev2)

I changed the Davicom's with Intel cards (same IRQ), and now it works
flawlessly. I think this might be an error worth looking at..

Hans K. Rosbach  aka. Dead2
CircleStorm Productions




-START ATTACHMENT-

Hi, i'm getting the following errors constantly while accessing my scsi disk
(10x per second or more)

"Kernel: scsi0: PCI error Interrupt at seqaddr = 0x*"
"Kernel: scsi0: Data Parity Error Detected during address or write data
phase"
(where * is a number, most often 8 or 9)

I'm running Kernel 2.4.6pre1 (also got it with 2.4.5)
Worked fine with the distro's kernel 2.4.0

Hardware:
  Adaptec SCSI 19160 Ultra160, 68/50pin  (7892B, rev2)
  MSI K7T-PRO2 motherboard (VIA chipset)
  Amd Duron 750Mhz cpu
  Winbond SDRAM (7ns)
  2x Davicom PCI 10/100 cards
  ATI 3D Rage IIc AGP

The computer is running SuSE 7.1 without X or other fancy
packages, as it is going to run a squid cache server.

The Scsi drivers are compiled into the kernel.

Hans K. Rosbach  aka. Dead2
CircleStorm Productions

-END ATTACHMENT-

