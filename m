Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRARLC1>; Thu, 18 Jan 2001 06:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129969AbRARLCS>; Thu, 18 Jan 2001 06:02:18 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:34057 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S129774AbRARLCA>;
	Thu, 18 Jan 2001 06:02:00 -0500
Date: Thu, 18 Jan 2001 12:01:29 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux not adhering to BIOS Drive boot order?
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Tim Fletcher <tim@parrswood.manchester.sch.uk>
Message-id: <3A66CD09.F0111CB5@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tim Fletcher <tim@parrswood.manchester.sch.uk> wrote :

> > How does MD/RAID0 know which array should be /dev/md0? What if you had a 
> > second array on /dev/hdb and /dev/hdd, would that become /dev/md0 (assuming 
> > it had a kernel/boot sector)? 
>    
> /etc/raidtab specifies which drives belong in which array, but I only have
>  hda and hdc so I can't really answer the question

What happens if /dev/md0 is /dev/sda and /dev/sdc ( the system also has
sdb )
and sda fails or is removed ?
the old sdb will now be sda and old-sdc will be sdb.
md0 will look into sda , which is now the non-md disk , and
sdc , which doesn't exists any more ???

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
