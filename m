Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132194AbRDCQlh>; Tue, 3 Apr 2001 12:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132223AbRDCQl2>; Tue, 3 Apr 2001 12:41:28 -0400
Received: from [212.17.18.2] ([212.17.18.2]:42769 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id <S132194AbRDCQlO>;
	Tue, 3 Apr 2001 12:41:14 -0400
Message-Id: <200104031639.XAA32695@gw.ac-sw.com>
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: linux-kernel@vger.kernel.org
Subject: EATA driver with DPT SmartRAID V
Date: Tue, 3 Apr 2001 23:38:12 +0700
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to make subj working on 2.4.2-ac28, but failed. Could you please give 
me some advise about the situation.

pci shows:

  Bus  1, device   1, function  0:
    PCI bridge: Distributed Processing Technology PCI Bridge (rev 2).
      Master Capable.  Latency=64.  Min Gnt=3.
  Bus  1, device   1, function  1:
    I2O: Distributed Processing Technology SmartRAID V Controller (rev 2).
      IRQ 24.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=1.
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].

When I try to modprobe driver I get:

[root@axis /root]# modprobe eata
/lib/modules/2.4.2-ac28/kernel/drivers/scsi/eata.o: init_module: No such 
deviceHint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
/lib/modules/2.4.2-ac28/kernel/drivers/scsi/eata.o: insmod 
/lib/modules/2.4.2-ac28/kernel/drivers/scsi/eata.o failed
/lib/modules/2.4.2-ac28/kernel/drivers/scsi/eata.o: insmod eata failed

I tried also default settings provided in eata.c, but this does not help. 

If anyone had a success with this device, please let me know.

Thanks in advance.

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
