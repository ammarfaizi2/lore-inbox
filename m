Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284199AbRLPCMK>; Sat, 15 Dec 2001 21:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284198AbRLPCMA>; Sat, 15 Dec 2001 21:12:00 -0500
Received: from fe010.worldonline.dk ([212.54.64.195]:44302 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S284197AbRLPCLu>; Sat, 15 Dec 2001 21:11:50 -0500
Date: Sun, 16 Dec 2001 03:10:52 +0100 (CET)
From: Niels Kristian Bech Jensen <nkbj@image.dk>
X-X-Sender: <nkbj@hafnium.nkbj.dk>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: CONFIG_SOUND_DMAP: Confusing Configure.help entry.
Message-ID: <Pine.LNX.4.33.0112160306270.3670-100000@hafnium.nkbj.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Configure.help entry for CONFIG_SOUND_DMAP (included below) leaves 
me a bit confused.  It says there can be a problem on machines with more 
than 16MB of RAM.  At the same time it says that CONFIG_SOUND_DMAP 
should be enabled unless you have more the 16MB of RAM (or a PCI sound 
card).  Is it my language skill (English is not my mother tongue) or is 
it a contradiction?  When should CONFIG_SOUND_DMAP be enabled?


Persistent DMA buffers
CONFIG_SOUND_DMAP
  Linux can often have problems allocating DMA buffers for ISA sound
  cards on machines with more than 16MB of RAM. This is because ISA
  DMA buffers must exist below the 16MB boundary and it is quite
  possible that a large enough free block in this region cannot be
  found after the machine has been running for a while. If you say Y
  here the DMA buffers (64Kb) will be allocated at boot time and kept
  until the shutdown. This option is only useful if you said Y to
  "OSS sound modules", above. If you said M to "OSS sound modules"
  then you can get the persistent DMA buffer functionality by passing
  the command-line argument "dmabuf=1" to the sound.o module.

  Say Y unless you have 16MB or more RAM or a PCI sound card.

-- 
Niels Kristian Bech Jensen -- nkbj@image.dk -- http://www.image.dk/~nkbj/

----------->>  Stop software piracy --- use free software!  <<-----------

