Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTAFCLt>; Sun, 5 Jan 2003 21:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265773AbTAFCLt>; Sun, 5 Jan 2003 21:11:49 -0500
Received: from mx5.mail.ru ([194.67.57.15]:31248 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id <S265754AbTAFCLs>;
	Sun, 5 Jan 2003 21:11:48 -0500
Date: Mon, 6 Jan 2003 05:14:12 +0300
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: fs corruption with 2.4.20 IDE+md+LVM
Message-ID: <20030106021412.GA3993@server1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I observed filesystem corruption on my home workstation recently. I was
> running kernel 2.4.20 (built myself with gcc 2.95.4), and ext3 with the
> default journaling mode (ordered?).

Hello, 

Same problem here. I have software raid-1 on 2 IDE Seagate 80G, kernel 
2.4.20aa1 built with gcc-3.2, all filesystems are ext2, no LVM. 
FS corruption after running Cerberus test for about 8 hours. 

> I will also point out that kernel 2.4.20-ac1 and 2.4.21-pre6 will not 
> boot on my machine; they kernel panic when detecting my IDE devices. 

I can confirm. Kernel 2.4.21-pre2 does not boot from a RAID device 
(/dev/md0). 

-- 

    D.V.
