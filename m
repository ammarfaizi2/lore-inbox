Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264465AbUDZJwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbUDZJwy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 05:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUDZJwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 05:52:54 -0400
Received: from [203.105.59.85] ([203.105.59.85]:59379 "EHLO mail.mailprove.com")
	by vger.kernel.org with ESMTP id S264465AbUDZJwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 05:52:50 -0400
Message-ID: <408CDBF1.90301@mailprove.com>
Date: Mon, 26 Apr 2004 17:52:49 +0800
From: Seve Ho <sho@mailprove.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mkinitrd error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to recompile kernel on Itanium2 Redhat box.( This is my 
first time to do it and actually I am new to Linux )
After recompilation, I tried to create initial ramdisk with mkinitrd. 
However, it failed with following error messages...
Does anyone have idea about what is jdb? And how can i make the ramdisk 
successfully?

Any help  or hints will be greatly appreciated.( I am not on the list, 
could you kindly cc your answer or suggestion to sho@mailprove.com ? )


Seve


[root@SDV900 root]# mkinitrd -v initrd-2.4.18-e.31custom20040426.img  
2.4.18-e.31custom20040426
Using modules:  ./kernel/drivers/scsi/scsi_mod.o 
./kernel/drivers/scsi/sd_mod.o 
./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx_2.o ./kernel/fs/jbd/jbd.o 
./kernel/fs/ext3/ext3.o
Using loopback device /dev/loop0
/sbin/nash -> /tmp/initrd.naSZEa/bin/nash
/sbin/insmod.static -> /tmp/initrd.naSZEa/bin/insmod
`/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/scsi_mod.o' 
-> `/tmp/initrd.naSZEa/lib/scsi_mod.o'
`/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/sd_mod.o' 
-> `/tmp/initrd.naSZEa/lib/sd_mod.o'
`/lib/modules/2.4.18-e.31custom20040426/./kernel/drivers/scsi/sym53c8xx_2/sym53c8xx_2.o' 
-> `/tmp/initrd.naSZEa/lib/sym53c8xx_2.o'
`/lib/modules/2.4.18-e.31custom20040426/./kernel/fs/jbd/jbd.o' -> 
`/tmp/initrd.naSZEa/lib/jbd.o'
`/lib/modules/2.4.18-e.31custom20040426/./kernel/fs/ext3/ext3.o' -> 
`/tmp/initrd.naSZEa/lib/ext3.o'
Loading module scsi_mod
Loading module sd_mod
Loading module sym53c8xx_2
Loading module jbd
Loading module ext3
*tar: ./lib/jbd.o: Wrote only 0 of 10240 bytes
tar: Skipping to next header
tar: Error exit delayed from previous errors*

-- 
Seve Ho
Programmer

Tel   (852) 3105 2920
Fax   (852) 3105 2926
Email Seve.Ho@MailProve.com


Mail Prove Ltd.
806, Cyberport 1
100 Cyberport Rd.
Pokfulam, H. K. 




