Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275211AbRJFPSB>; Sat, 6 Oct 2001 11:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275224AbRJFPRw>; Sat, 6 Oct 2001 11:17:52 -0400
Received: from [213.97.199.90] ([213.97.199.90]:896 "HELO fargo")
	by vger.kernel.org with SMTP id <S275211AbRJFPRo> convert rfc822-to-8bit;
	Sat, 6 Oct 2001 11:17:44 -0400
From: davidge@jazzfree.com
Date: Sat, 6 Oct 2001 17:15:22 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Some ext2 errors
Message-ID: <Pine.LNX.4.33.0110061713130.485-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

First i thought this errors has some relation with kernel 2.4.10 and
e2fsprogs, but i switched back to 2.4.9 and again i got this
ext2_check_page error.

Oct  6 17:11:08 fargo kernel: EXT2-fs error (device ide0(3,1)):
ext2_check_page: bad entry in directory #423505: unaligned directory entry
- offset=0, inode=6517874, rec_len=12655, name_len=48
Oct  6 17:11:08 fargo kernel: hda: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
Oct  6 17:11:08 fargo kernel: hda: drive not ready for command
Oct  6 17:11:08 fargo kernel: hdb: ATAPI DVD-ROM drive, 512kB Cache
Oct  6 17:11:08 fargo kernel: Uniform CD-ROM driver Revision: 3.12
Oct  6 17:11:09 fargo kernel: VFS: Disk change detected on device
ide0(3,64)


Any hints are welcome, thanks.


David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


