Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290012AbSAWTrY>; Wed, 23 Jan 2002 14:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290015AbSAWTrR>; Wed, 23 Jan 2002 14:47:17 -0500
Received: from julia.fractalus.com ([209.26.177.217]:62478 "HELO
	julia.fractalus.com") by vger.kernel.org with SMTP
	id <S290012AbSAWTrC>; Wed, 23 Jan 2002 14:47:02 -0500
Date: Wed, 23 Jan 2002 14:40:56 -0500
From: SteveC <steve@fractalus.com>
To: linux-kernel@vger.kernel.org
Subject: PCI intel 440 chipset weirdness
Message-ID: <20020123144055.A2956@fractalus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux/2.2.19-6.2.10 (i686)
X-Uptime: 2:30pm  up 30 days,  2:42,  3 users,  load average: 0.05, 0.02, 0.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan 23 15:14:01 bat kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd091, 
last bus=1
Jan 23 15:14:01 bat kernel: PCI: Using configuration type 1
Jan 23 15:14:01 bat kernel: PCI: Probing PCI hardware
Jan 23 15:14:01 bat kernel: PCI: i440KX/GX host bridge 00:19.0: secondary 
bus 00
Jan 23 15:14:01 bat kernel: PCI: i440KX/GX host bridge 00:1a.0: secondary 
bus 01
Jan 23 15:14:01 bat kernel: PCI: Cannot allocate resource region 0 of 
device 00:0f.0
Jan 23 15:14:01 bat kernel: PCI: Cannot allocate resource region 1 of 
device 00:0f.0
Jan 23 15:14:01 bat kernel: PCI: Cannot allocate resource region 2 of 
device 00:0f.0
Jan 23 15:14:01 bat kernel: PCI: Cannot allocate resource region 3 of 
device 00:0f.0
Jan 23 15:14:01 bat kernel: PCI: Cannot allocate resource region 4 of 
device 00:0f.0
Jan 23 15:14:01 bat kernel: PCI: Cannot allocate resource region 5 of 
device 00:0f.0
Jan 23 15:14:01 bat kernel: PCI: Error while updating region 00:0f.0/1 
(20000408 != 20000008)
Jan 23 15:14:01 bat kernel: PCI: Error while updating region 00:0f.0/2 
(20000808 != 20000008)
Jan 23 15:14:01 bat kernel: PCI: Error while updating region 00:0f.0/3 
(20000c08 != 20000008)
Jan 23 15:14:01 bat kernel: PCI: Error while updating region 00:0f.0/4 
(20001008 != 20000008)
Jan 23 15:14:01 bat kernel: PCI: Error while updating region 00:0f.0/5 
(20001408 != 20000008)

kernel 2.4.17

I look around and found bits like:

http://bizforums.itrc.hp.com/cm/QuestionAnswer/1,,0xd296ee3e323bd5118fef0090279cd0f9,00.html

The machine seems to behave fine but i took it back to 2.2.whatever 
anyway. Can anyone give me an idea what to do?

have fun,

SteveC steve@fractalus.com fractalus.com/steve
