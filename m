Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261641AbSIXKrD>; Tue, 24 Sep 2002 06:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSIXKrD>; Tue, 24 Sep 2002 06:47:03 -0400
Received: from ns.crescendo.ro ([194.235.240.134]:19210 "EHLO ns.crescendo.ro")
	by vger.kernel.org with ESMTP id <S261641AbSIXKrC> convert rfc822-to-8bit;
	Tue, 24 Sep 2002 06:47:02 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Alex <devel@qnet.ro>
To: linux-kernel@vger.kernel.org
Subject: HOT SWAP PROBLEM using hp4100 server series
Date: Tue, 24 Sep 2002 13:50:50 +0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209241350.50702.devel@qnet.ro>
X-RAVMilter-Version: 8.3.3(snapshot 20020312) (mail.masini.ro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux experts,


I don`t know if i come to the right place


I have a HP 4100 server with LSI 53c1010R SCSI controller. I use 
RedHat7.3 os with default kernel 2.4.18-3. Also i have 3 scsi drives 
36G Ultra3 firmware HP. All thins are ok till here.


I need some help to test HOT SWAP feature for this drives. I read some 
documentation and i saw that HOT SWAP may work if my driver for 
scsi-controller support re-scanning the bus.


[snip]
Normal SCSI hardware is not hot-swappable either. It may however work. 
If your SCSI driver supports re-scanning the bus, and removing and 
appending devices, you may be able to hot-swap devices.


I try to check if this feature works for me and don`t. If i remove any 
scsi drive, this device remain in /proc until will be removed manually, 
or using a script named rescan-scsi-bus.sh which i found it on google.


I try to obtain some additional info and i saw that for my 
scsi-controller has 2 active drivers: one older named sym53cxx.o and 
one newer named sym53cxx_2.o!
I don`t have for the moment access to this computer but i remember that 
on default installation, redhat assigned the old driver to my 
scsi-controller.


I want to know if i change the driver with this new one, i can use the 
HOT SWAP feature!


Are necessary additional settings to be made when i load the new driver 
or on the system configuration?


Any success story will be appreciated.


Regards,


Alex

