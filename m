Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSF2P1T>; Sat, 29 Jun 2002 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSF2P1S>; Sat, 29 Jun 2002 11:27:18 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:43137
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S312962AbSF2P1R>; Sat, 29 Jun 2002 11:27:17 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200206291529.g5TFTTX14615@www.hockin.org>
Subject: Re: IO and PCIy
To: sheltraw@unm.edu
Date: Sat, 29 Jun 2002 08:29:29 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1025335902.3d1d625ef2db3@webmail.unm.edu> from "sheltraw@unm.edu" at Jun 29, 2002 01:31:42 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way to disable IO read/writes to a PCI device. The bit 0
> of command register in PCI configuration space can be used to 
> disable/enable memory-mapped IO but will it disable direct IO 
> (what is the proper term?) as well?
 
 There are two bits - IO enable and MMIO enable.  They are the 0x1 and 0x2
 bits in the command register, respectively.
 
> enable interrupts on vertical blanking without doing so on both 
> cards (since they both respond to the same direct IO addresses). 
 
 umm, should they be on the same IO?  I've never mucked with dual video
 cards, but that sounds odd...
 
> Of course if I knew the addresses/offsets for memory-mapped versions
> of the appropriate registers on one card I could solve this problem
> but I do not neccesarily have that info.

The pci regions are easily readable - you should dig up a copy of the PCI
spec - very good reading....
