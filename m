Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132658AbRDGO3j>; Sat, 7 Apr 2001 10:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132659AbRDGO3V>; Sat, 7 Apr 2001 10:29:21 -0400
Received: from jalon.able.es ([212.97.163.2]:59567 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132658AbRDGO3J>;
	Sat, 7 Apr 2001 10:29:09 -0400
Date: Sat, 7 Apr 2001 16:28:35 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: gibbs@scsiguy.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: aic7xxx 6.1.10 breaks 2.4.3-ac3
Message-ID: <20010407162835.A18620@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Subject says it all.

With latest updates, i just deleted the kernel aic7xxx subtree, put instead
the updated (from people.freebsd.org) tree, and built. All went fine
until (and including) 6.1.9.

6.1.10 just stops after the init messages and stays there forever.

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.9
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs

(6.1.10 stops here)

  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

