Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284557AbRLXKJh>; Mon, 24 Dec 2001 05:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284553AbRLXKJ1>; Mon, 24 Dec 2001 05:09:27 -0500
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:640 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S284546AbRLXKJJ>;
	Mon, 24 Dec 2001 05:09:09 -0500
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200112240930.fBO9U9b01874@meduna.org>
Subject: IDE CDROM locks the system hard on media error
To: linux-kernel@vger.kernel.org
Date: Mon, 24 Dec 2001 10:30:09 +0100 (CET)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am catalogizing my set of CDs and so I have tortured my CD drive
with a bunch of less-than-optimal CDs. I had two hard lockups
most probably connected to problematic media.

The last message in log is

 kernel: scsi0: ERROR on channel 0, id 0, lun 0,
   CDB: Request Sense 00 00 00 40 00 
 kernel: Current sd0b:00: sense key Medium Error
 kernel: Additional sense indicates No seek complete
 kernel:  I/O error: dev 0b:00, sector 504
 kernel: ISOFS: unable to read i-node block

Shortly (but not immediately, the kernel tried a bit more to get
some data from the drive) after that the system froze - not even
SysRq worked.

I am using vanilla 2.4.17, hdc=ide-scsi, my drive is Mitsumi CR-4804TE,
motherboard is Abit BP6 SMP, Intel PIIX4 IDE controller,

More details available upon request. Please, Cc: replies to me.

Regards
-- 
                                   Stano

