Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSKUJes>; Thu, 21 Nov 2002 04:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSKUJes>; Thu, 21 Nov 2002 04:34:48 -0500
Received: from pc4-cmbg2-6-cust191.cam.cable.ntl.com ([213.104.13.191]:5624
	"HELO flop.localnet") by vger.kernel.org with SMTP
	id <S266478AbSKUJer>; Thu, 21 Nov 2002 04:34:47 -0500
Date: Thu, 21 Nov 2002 09:41:46 +0000 (GMT)
From: m@ttvenn.net
To: linux-kernel@vger.kernel.org
Subject: ext2-fs corruption on 2.4.18
Message-Id: <Pine.LNX.4.21.0211210934270.8924-100000@flop.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been getting some oopses regarding fs corruption, and getting
these in the logs:

Sep 26 10:38:13 flop kernel: EXT2-fs error (device ide2(33,1)):
ext2_free_branches: Read failure, inode=8732674, block=-1

Nov  3 04:47:52 flop kernel: EXT2-fs error (device ide0(3,3)):
ext2_free_blocks: Freeing blocks not in datazone - block = 757096807,
count = 1

Logs show errors on all ide devices, indicating sw rather than hw?
Though my disks are running rather hot, could this be a reason
perhaps.

All disks are Fujitsus, /proc shows the models as

FUJITSU MPG3409AT E
FUJITSU MPE3273AH

The motherboard is an ABIT kt7.

uname -a shows

Linux flop 2.4.18 #1 Sun Sep 29 20:23:13 BST 2002 i686 unknown

Could any replies be cc'd to m@ttvenn.net.

Thanks,

Matt

-- 
#!/usr/bin/perl
$A='A';while(print+($A.=(grep{($A=~/(...).{78}$/)[0]eq$_}"  A A A  "
=~m{(...)}g)?"A":" ")=~/([ A])$/){if(!(++$l%80)){print"\n";sleep 1}}

