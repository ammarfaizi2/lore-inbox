Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSI2RON>; Sun, 29 Sep 2002 13:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSI2RON>; Sun, 29 Sep 2002 13:14:13 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:52514 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261446AbSI2ROL> convert rfc822-to-8bit;
	Sun, 29 Sep 2002 13:14:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@gmx.net>
To: "Theodore Ts'o" <tytso@mit.edu>, "Christopher Li" <chrisl@gnuchina.org>,
       "Ryan Cumming" <ryan@completely.kicks-ass.org>
Subject: Re: ARGS [PATCH] fix htree dir corrupt after fsck -fD
Date: Sun, 29 Sep 2002 19:19:14 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209291918.55303.m.c.p@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

> I am running your program now over an hour without any corruption on the 
> loopback mounted ext3 filesystem.
shit, I thought testing over an hour (10mins your program, umount, fsck -fD 
test.img in a loop) is enough but it isn't. Damn f*ck :(

root@codeman:[/] # fsck -fD test.img 
fsck 1.29 (24-Sep-2002)
e2fsck 1.29 (24-Sep-2002)
Truncating orphaned inode 6871 (uid=0, gid=0, mode=0103244, size=0)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Problem in HTREE directory inode 2 (/): bad block number 3291184.
Clear HTree index<y>? yes

Pass 3: Checking directory connectivity
/lost+found not found.  Create<y>? yes

Pass 3A: Optimizing directories
Optimizing directories:  2
Pass 4: Checking reference counts
Pass 5: Checking group summary information

this occured just after I sent my first mail :((

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.

