Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUHFK3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUHFK3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUHFK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:29:22 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:155 "EHLO hibernia.jakma.org")
	by vger.kernel.org with ESMTP id S268120AbUHFK3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:29:18 -0400
Date: Fri, 6 Aug 2004 11:29:12 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: libata: dma, io error messages
Message-ID: <Pine.LNX.4.60.0408061113210.2622@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I received a mail this morning from mdadm to notify me of a RAID 
event. A partition, sda3, was kicked from a RAID5 array. Following 
error was logged in dmesg/syslog:

ata1: DMA timeout, stat 0x1
ATA: abnormal status 0xD0 on port 0xD081B087
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 02 05 d0 06 00 00 10 00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 33935366
ATA: abnormal status 0xD0 on port 0xD081B087
Aug  6 06:03:58 hibernia last message repeated 2 times

Can anyone shed light on the precise meaning and/or implications of 
above? Particularly the additional sense message, "auto reallocate 
failed" does this mean the drive is out of spare blocks?

Also, the drive is extremely slow now, about 1MB/s drive transfer 
rate as reported by hdparm -T.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
"Consequences, Schmonsequences, as long as I'm rich."
 		-- "Ali Baba Bunny" [1957, Chuck Jones]
