Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbREFKkQ>; Sun, 6 May 2001 06:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbREFKj5>; Sun, 6 May 2001 06:39:57 -0400
Received: from tartu-gw.cv.ee ([213.168.20.162]:15821 "EHLO tartu.cv.ee")
	by vger.kernel.org with ESMTP id <S135426AbREFKjr>;
	Sun, 6 May 2001 06:39:47 -0400
Date: Sun, 6 May 2001 12:39:44 +0200 (EET)
From: Janek <janek@tartu.cv.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4 ide problems.
Message-ID: <Pine.LNX.4.21.0105061221540.24591-100000@eit.cvo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Asus K7V motherboard with Athlon 750. I have one harddisc cnnected
to primary channel and CDrom connected to secondary.
The primary is connected with 40 pin 80 conductor ide cable and the
secondary is connected with 40 pin standard cable.

Everything but reading from the CDrom is working. When I insert a CD I can
list files on it but when I copy something to harddisk then size of the
file is the same but mdsum's do not match.

When I connect the CDrom to the primary cable everything is working.

When I connect the harddisc with standard cable to primary and CDrom with
80 conductor cable to secondary everything is working.

The main problem was when I tried to install RedHat 7.1 which uses 2.4.2
kernel....and it could not start install because some data read was bad.

So my guess is when CDrom is connected with standard cable kernel
gets some false information and the data cannot be read reliably from
CDrom.

Kernel outputs in both cases :
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(66)
hdb: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)

If more testing is needed I'll be glad to help out ...


Janek

