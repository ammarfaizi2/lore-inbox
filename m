Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261988AbRE3ULp>; Wed, 30 May 2001 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbRE3ULZ>; Wed, 30 May 2001 16:11:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55303 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261988AbRE3ULP>; Wed, 30 May 2001 16:11:15 -0400
Subject: Re: ln -s broken on 2.4.5
To: mm@ns.caldera.de (Marcus Meissner)
Date: Wed, 30 May 2001 21:08:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200105301923.f4UJNl815303@ns.caldera.de> from "Marcus Meissner" at May 30, 2001 09:23:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155CH3-0006XA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What file system. Its find on my 2.4.5-ac with ext2
> 
> 100% reproducible on NFS and EXT2 here, with following:


> $ ls -la bar
> lrwxrwxrwx   1 marcus   users           3 May 30 20:30 bar -> bar

bash-2.04$ uname -a
Linux irongate.swansea.linux.org.uk 2.4.5-ac2 #163 Mon May 28 22:56:38 BST 2001 i686 unknown
bash-2.04$ ln -s frobnitz flop
bash-2.04$ ls -l f*
lrwxrwxrwx    1 alan     users           8 May 30 20:50 flop -> frobnitz

bash-2.04$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81


