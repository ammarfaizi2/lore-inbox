Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271951AbRIDOhF>; Tue, 4 Sep 2001 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271941AbRIDOgx>; Tue, 4 Sep 2001 10:36:53 -0400
Received: from ns1ca.ubisoft.qc.ca ([205.205.27.131]:12041 "EHLO
	ns1ca.ubisoft.qc.ca") by vger.kernel.org with ESMTP
	id <S271937AbRIDOgm>; Tue, 4 Sep 2001 10:36:42 -0400
Message-ID: <9A1957CB9FC45A4FA6F35961093ABB84043F1D0E@srvmail-mtl.ubisoft.qc.ca>
From: Patrick Allaire <pallaire@gameloft.com>
To: linux-kernel@vger.kernel.org
Subject: Failure to mount root fs ...
Date: Tue, 4 Sep 2001 10:28:42 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am currently trying to boot for a DiscOnChip with mtd drivers. When I boot
the system stop with the following message : "Kernel panic: VFS: Unable to
mount root fs on 03:05" !

I know that o3:05 mean : /dev/hda5. HTis is where I did compile my kernel
... but now the kernel is on /dev/nftla1 ... but the lilo.conf on this
device is configured to nftla1 and I did run lilo??? so I dont know where
the kernel take this information about boot ing on /dev/hda5 ??? I am using
the lilo modified to support mtd.

here is my lilo.conf

boot=/dev/nftla
map=/boot/map
install=/boot/boot.b-mtd
vga=extended
image=/boot/bzImage
label=s
root=/dev/nftla1
read-write



Patrick Allaire
mailto:pallaire@gameloft.com
If you can see it, but it's not there, it's virtual. 
If you can't see it, but it is there, it's hidden. 
It you can't see it and it isn't there, it's gone.


