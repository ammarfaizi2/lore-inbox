Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRAaRVt>; Wed, 31 Jan 2001 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRAaRVi>; Wed, 31 Jan 2001 12:21:38 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:4358 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S131409AbRAaRVV>;
	Wed, 31 Jan 2001 12:21:21 -0500
Date: Wed, 31 Jan 2001 18:21:04 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Vanilla 2.4.0 ext2fs error
Message-ID: <Pine.LNX.4.30.0101311805470.29461-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can someone 'translate' this for me ?


Jan 31 18:01:57 base kernel: EXT2-fs error (device ide0(3,71)):
ext2_new_inode:
reserved inode or inode > inodes count - block_group = 0,inode=1

It's reproducable, but doesn't seem to give any problems.
It happens when on a (almost) emty FS an links is attempted to a directory
that doesn't exist at that point.

I'll try 2.4.1 when I get back and see what that does..


	Regards,


		Igmar


-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
