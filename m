Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264103AbRFFTLO>; Wed, 6 Jun 2001 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264102AbRFFTKy>; Wed, 6 Jun 2001 15:10:54 -0400
Received: from jalon.able.es ([212.97.163.2]:6350 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264103AbRFFTKr>;
	Wed, 6 Jun 2001 15:10:47 -0400
Date: Wed, 6 Jun 2001 21:10:39 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ide speeds
Message-ID: <20010606211039.A1565@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A little test-question. I am getting some strange timings...

Hardware: PIIX4:
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at ffa0 [size=16]
and a Creative 52mx CD-ROM (managed with kernel ide, master on IDE1)
and a Yamaha 8424 CDRW (also IDE, with ide-scsi+sg).

Software: 2.4.5-ac9+andre-ide-patch
Test: read a big file (634Mb) to disk.

The copy takes nearly 9 minutes from the 52x Creative and 3.5 from the
24x Yamaha. ???

Can it be soft ? The difference between ide-scsi and native ide ?
Or just the Creative hardware is s... ?

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac9 #1 SMP Wed Jun 6 09:57:46 CEST 2001 i686
