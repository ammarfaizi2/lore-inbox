Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129290AbRB1Vi5>; Wed, 28 Feb 2001 16:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129284AbRB1Vis>; Wed, 28 Feb 2001 16:38:48 -0500
Received: from md.aacisd.com ([64.23.207.34]:37904 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S129283AbRB1Vik>;
	Wed, 28 Feb 2001 16:38:40 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D6718A0@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: "'Cappellini, Tony'" <Tony_Cappellini@maxtor.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM- Segmentation fault occurs when dd'ing entire drive (
	9.x  GB) to a vfat partition.
Date: Wed, 28 Feb 2001 16:33:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is NOT a dd problem. I have been trying to write large files to a vfat
filesystem. This is definitely a bug with the kernel. I have had the seg
fault. Try running the program again, but look at your console. It think
that it will result in a kernel bug statement.I think that mine said it was
in File.c:89 .

Nathan

P.S. I was trying to capture atm data on the partition. The code I am using
works great with an ext2fs partition, but the vfat dies at exactly the same
place.


-----Original Message-----
From: Cappellini, Tony [mailto:Tony_Cappellini@maxtor.com]
Sent: Wednesday, February 28, 2001 4:09 PM
To: 'linux-kernel@vger.kernel.org'
Subject: PROBLEM- Segmentation fault occurs when dd'ing entire drive
(9.x GB) to a vfat partition.
Importance: High



Hello


I am submitting this bug report. I've attached a file which I hope contains
all of the approppriate information.

Is it possible for someone to let me know if/when this problem is fixed ?

Thanks




Tony Cappellini

Maxtor Corporation


