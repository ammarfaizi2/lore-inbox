Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129682AbRBWCAd>; Thu, 22 Feb 2001 21:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130160AbRBWCAX>; Thu, 22 Feb 2001 21:00:23 -0500
Received: from masternode.net ([24.144.24.34]:7940 "EHLO masternode.net")
	by vger.kernel.org with ESMTP id <S129682AbRBWCAE>;
	Thu, 22 Feb 2001 21:00:04 -0500
Date: Thu, 22 Feb 2001 20:00:02 -0600
To: linux-kernel@vger.kernel.org
Subject: CS4232 sound questions
Message-ID: <20010222200002.A451@gezr.masternode.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Phil Smith <phil@masternode.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have come to the pont of having to mail this list in search of a greater
understanding of what I could possibably be doing wrong in reguards to 
enabling my sound card.  Under 2.2.X I was able to include the cards 
configuration during the config, yes, I understand that this has changed
in opt for other methods.  These methods though are very strange and 
somewhat unclear in the current documentation set.  I have tried several
possible built-in and modular configs with the results being the same, below 
I will include information that may or may not be what is necessary to get 
possible solutions to this, but odd or exact suggestions will be greatly 
appreciated.  Thank you,  Phil Smith
 
The mother board is a pr440fx intel board.
Dual ppro 200 cpus
Linux version 2.4.1 (root@gezr) (gcc version 2.95.3 20010125 (prerelease)) #8 SMP Thu Feb 22 17:44:42 CST 2001

dmesg information concerning the card

PCI->APIC IRQ transform: (B0,I17,P0) -> 18
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Card 'CS4236B Audio'
isapnp: 1 Plug & Play card detected total

ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996




lilo config line  (kernel boot parameter?)
append="cs4232=0x534,5,0,3,0x330,9"

14 sound       shows in /proc/devices


initial lines from /proc/isapnp   (all sound card coresponding devices
show as "not active"  activation can be achieved via isapnptools and
no sound working from that):

Card 1 'CSC0b35:CS4236B Audio' PnP version 1.0 Product version 0.1
  Logical device 0 'CSC0000:WSS/SB'
      Device is not active
      Resources 0
      Priority preferred
      Port 0x534-0x534, align 0x3, size 0x4, 16-bit address decoding


P.S. I perfer to not use modules for sound, that may be odd, I'm not sure 
about that, but I see no reason why what I have chosen to use, not to work, 
I can only hope that I have missed an important note somewhere and a simple 
answer will raise its head.  
