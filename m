Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTBQMJN>; Mon, 17 Feb 2003 07:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267034AbTBQMJN>; Mon, 17 Feb 2003 07:09:13 -0500
Received: from webmail32.rediffmail.com ([203.199.83.32]:51114 "HELO
	rediffmail.com") by vger.kernel.org with SMTP id <S267033AbTBQMJM>;
	Mon, 17 Feb 2003 07:09:12 -0500
Date: 17 Feb 2003 12:25:26 -0000
Message-ID: <20030217122526.19514.qmail@webmail32.rediffmail.com>
MIME-Version: 1.0
From: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
Reply-To: "Nandakumar  NarayanaSwamy" <nanda_kn@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: CRAMFS on Flash
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

I succeeded in making the target board booting using CRAMFS with 
initrd.
Since initrd will uncompress the image and load the file system to 
RAM i face the lack of memory problem in RAM.

So i just wanted to make the kernel boot with the CRAMFS in flash. 
I had seen the old mailing list archives related to that. I still 
have some clarifications regarding that.

1) Where to create the mtd partitions for the file system in 
flash? First i just want to create a simple CRAMFS with some 
binaries and executables and then mount it using mount command i.e 
like
mount -t cramfs /dev/mtdblock0 /home

I would appreciate if somebody could help me to sort out this 
issue.
Thanks in advance,
Nanda

