Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131392AbRC0QUN>; Tue, 27 Mar 2001 11:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131393AbRC0QUD>; Tue, 27 Mar 2001 11:20:03 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17427 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131392AbRC0QTq>; Tue, 27 Mar 2001 11:19:46 -0500
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
To: puckwork@madz.net (Thomas Foerster)
Date: Tue, 27 Mar 2001 17:21:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010327064904Z130600-406+4294@vger.kernel.org> from "Thomas Foerster" at Mar 27, 2001 08:48:08 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14hwE9-0003rW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Freeing unused kernel memory: xxk freed
> 
> So we took the box home and tried to boot it from a bootdisk (generated as we installed the box,
> redhat 7.0). The SAME problem occurs ... 
> 
> Freeing unused kernel memory: xxk freed
> 
> The system hangs (i've tried 2.2.18 AND 2.4.2-ac20, 2.2.16 is on our bootdisk). I thought
> it could be the swap-partition ... so we inserted an IDE Disk, installed a small system so that
> i was able to mount the SCSI-Disks. So i rebuild the swap-parition with
> mkswap /dev/sda5 and activated it via swapon /dev/sda5 ... worked.
> 
> So i tried to boot it again from the SCSI-Disks ... nothing! The same odd failure ...

Boot off the ide disk and fsck the scsi disks. See if that helps


