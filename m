Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVHLTWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVHLTWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 15:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVHLTW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 15:22:29 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:10638 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP
	id S1751254AbVHLTW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 15:22:28 -0400
Message-ID: <47285.62.1.10.150.1123874953.squirrel@webmail.wired-net.gr>
In-Reply-To: <Pine.LNX.4.61.0508110835480.14365@chaos.analogic.com>
References: <42FB435E.2070607@effigent.net>
    <Pine.LNX.4.61.0508110835480.14365@chaos.analogic.com>
Date: Fri, 12 Aug 2005 22:29:13 +0300 (EEST)
Subject: fdisk & LBA
From: "Nanakos Chrysostomos" <nanakos@wired-net.gr>
To: linux-c-programming@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reply-To: nanakos@wired-net.gr
User-Agent: SquirrelMail/1.4.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,i want to retrieve the partition table of a primary extended
partition.
My MBR partition table ,says that the LBA Partition Start sector for the
extended partition is 10281600.It is the same that i find with my C code
and through fdisk usage.
How can i use this value to seek(lseek) to this point through the main
block file (/dev/hda or /dev/hdb) and read the partition table of the
logical partition?



Thanks in advance.

