Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbRAWTmu>; Tue, 23 Jan 2001 14:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130157AbRAWTml>; Tue, 23 Jan 2001 14:42:41 -0500
Received: from balance.uoregon.edu ([128.223.94.47]:29445 "EHLO
	balance.uoregon.edu") by vger.kernel.org with ESMTP
	id <S129789AbRAWTmW>; Tue, 23 Jan 2001 14:42:22 -0500
Date: Tue, 23 Jan 2001 11:38:39 -0800 (PST)
From: Dan Graham <graham@balance.uoregon.edu>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Under 2.4.0 I can mount same partition twice.
In-Reply-To: <Pine.LNX.4.10.10101231115130.10492-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0101231132000.934-100000@balance.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;
  I don't know if this is a bug or a feature.  While I was
playing around with 2.4.0 I (mistakenly) mounted an ext2
partition twice.  

The excerpt from mount looks like this.
/dev/hda1 on /a1 type ext2 (rw)
/dev/hda1 on /mnt type ext2 (rw)

Under 2.2.13 I get 

mount: /dev/hda1 already mounted or /mnt busy
mount: according to mtab, /dev/hda1 is mounted on /a1

Is this a bug or a feature? 

System is an ABIT VP6, dual PIII 733Mhz, 1gb RAM, 
30g ATA 100 drive, IBM Deskstar.  DMA is on.

Dan 
graham@balance.uoregon.edu


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
