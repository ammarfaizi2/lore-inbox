Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278396AbRKAI3H>; Thu, 1 Nov 2001 03:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278424AbRKAI25>; Thu, 1 Nov 2001 03:28:57 -0500
Received: from adiemus.org ([129.210.16.110]:47801 "EHLO adiemus.org")
	by vger.kernel.org with ESMTP id <S278396AbRKAI2u>;
	Thu, 1 Nov 2001 03:28:50 -0500
Date: Thu, 1 Nov 2001 00:28:57 -0800 (PST)
From: Chris Tracy <ctracy@adiemus.org>
To: <linux-kernel@vger.kernel.org>
Subject: Missing symbols with CONFIG_HIGHMEM
Message-ID: <Pine.LNX.4.30.0111010024030.10052-100000@adiemus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded my system to 1GB of RAM and in doing so, compiled my
kernel with CONFIG_HIGHMEM and CONFIG_HIGHMEM4G.  However, the following
modules now all report the same unresolved symbols:

loop.o
minix.o
smbfs.o
umsdos.o

	The missing symbols are:

kunmap_high
highmem_start_page
kmap_high

	I'm using linux-2.4.13-ac5.

	Let me know if you need more info.  Please CC me as I'm not on the
list.

	Thanks,

	Chris

---------------------------------
Chris Tracy
System/Network Administrator
Engineering Design Center
Santa Clara University
"Wherever you go, there you are."


