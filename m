Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277687AbRJRNBh>; Thu, 18 Oct 2001 09:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277626AbRJRNBR>; Thu, 18 Oct 2001 09:01:17 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:48393 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S277598AbRJRNBP>; Thu, 18 Oct 2001 09:01:15 -0400
From: Norbert Preining <preining@logic.at>
Date: Thu, 18 Oct 2001 15:01:41 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.12 cannot find root device on raid
Message-ID: <20011018150141.A17493@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have the following problem:

kernel 2.4.12, md and raid1 compiled into the kernel.
/dev/hdb old linux installation
/dev/md0 -> /dev/hde1,/dev/hdg1 new installation

When I boot my old installation the md device is automatically configured
by the kernel and I can mount it (reiserfs) without any problems.

When I try to boot the new installation with the same kernel the md device
is initialized, but the kernel cannot mount the root device. I get msgs
about FAT problems and about mounting root as msdos.

Here some config files:
lilo.conf:
image = /boot/lx-2.4.12
	root = /dev/hdb1
	label = old
image = /boot/lx-2.4.12
	root = /dev/md0
	label = new
	optional

Thanks a lot for any information

Best wishes

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
LOUTH (n.)

The sort of man who wears loud check jackets, has a personalised
tankard behind the bar and always gets served before you do.

			--- Douglas Adams, The Meaning of Liff 
