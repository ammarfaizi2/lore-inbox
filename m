Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132933AbRAGUrW>; Sun, 7 Jan 2001 15:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135762AbRAGUrM>; Sun, 7 Jan 2001 15:47:12 -0500
Received: from pop3.web.de ([212.227.116.81]:65039 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S132933AbRAGUrA>;
	Sun, 7 Jan 2001 15:47:00 -0500
Date: Sun, 7 Jan 2001 21:48:38 +0100
From: Michael Duelli <m.duelli@web.de>
To: linux-kernel@vger.kernel.org
Subject: Ext2 (dma ?) error
Message-ID: <20010107214838.A1086@Unimatrix01.surf-callino.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

recently I was on the internet with kernel 2.4.0-prerelease.
Suddenly Netscape hung and I couldn't help hard rebooting.

Fsck discovered an error it wasn't able to fix. This error never
appeared before and my Seagate HD actually should be alright.

The following error message appears everytime I check /dev/hda3
and when I tries to access the blocks involved in this error.
Now here it is:

--------------snip---------------------
hda: dma_intr: status=0x51 { DriveReady SeekCompleteError }
hda: dma_intr: error=0x40 { UncorrectableError } LBAsect = 2421754, sector
210048
end_request: I/O error, dev 03:03 (hda), sector 2100448

hda: dma_intr: status=0x51 { DriveReady SeekCompleteError }
hda: dma_intr: error=0x40 { UncorrectableError } LBAsect = 2421754, sector
210048
end_request: I/O error, dev 03:03 (hda), sector 2100448

Error reading block 262556 (Attempt to read block from filesystem resultet
in
short read) while doing inode scan. Ignore error <y>?
----------------snip---------------------

badblocks found about 44 bad blocks.

So I really want to know how to get rid of this error.
Is it a hardware error ( well at least I don't think so )?
Is it correctable with some special tricks ?
Would reformating solve the error.

My system configuration is:
Duron 700, Biostar mainboard, 128 MB, 30 GB Seagate ST-330630A

Any help is appreciated

TIA

P.S.: I am not in the list so please also CC directly to my e-mail
address, THX.
_________________________________________
Michael Duelli
m.duelli@web.de
linuxmaths.sourceforge.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
