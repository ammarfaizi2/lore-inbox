Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293144AbSBWPGY>; Sat, 23 Feb 2002 10:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293143AbSBWPGO>; Sat, 23 Feb 2002 10:06:14 -0500
Received: from jalon.able.es ([212.97.163.2]:9928 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S293144AbSBWPF6>;
	Sat, 23 Feb 2002 10:05:58 -0500
Date: Sat, 23 Feb 2002 16:05:44 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: floppy in 2.4.17
Message-ID: <20020223160544.A1905@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I am getting problems with floppy drive in 2.4.17.
All started with floppy not working in 18-rc4, went back to 17
and still does not work. Just plain 2.4.17, no patching.

mkfs -t ext2 /dev/fd0 just hangs forever.

mkfs -v -t ext2 /dev/fd0 gives:

mke2fs 1.26 (3-Feb-2002)
mkfs.ext2: bad blocks count - /dev/fd0

Hardware:

Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ide-floppy driver 0.97.sv

???

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.17 #2 SMP Sat Feb 23 15:08:17 CET 2002 i686
