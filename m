Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310356AbSCGPXp>; Thu, 7 Mar 2002 10:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCGPXg>; Thu, 7 Mar 2002 10:23:36 -0500
Received: from sip-11a.usol.com ([63.64.148.11]:26372 "EHLO
	dns1.civic.twp.ypsilanti.mi.us") by vger.kernel.org with ESMTP
	id <S310356AbSCGPXZ>; Thu, 7 Mar 2002 10:23:25 -0500
Subject: Re: 8139too on Proliant
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: Masoud Sharbiani <masouds@oeone.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8784E8.78B2D878@oeone.com>
In-Reply-To: <1015510399.25062.1.camel@smiddle> 
	<3C8784E8.78B2D878@oeone.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 10:23:26 -0500
Message-Id: <1015514607.25062.28.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't look like it:

dns1:/home/smiddle# modprobe via-rhine
/lib/modules/2.4.9-686/kernel/drivers/net/via-rhine.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.9-686/kernel/drivers/net/via-rhine.o: insmod
/lib/modules/2.4.9-686/kernel/drivers/net/via-rhine.o failed
/lib/modules/2.4.9-686/kernel/drivers/net/via-rhine.o: insmod via-rhine
failed
dns1:/home/smiddle# 

Just to clarify, the exact model is a DFE530TX+.  I use this exact same
card on most my machines at home, with the 8139too driver as well.  They
work fine.

Also, from /proc/pci:

Bus  0, device   4, function  0:
    Ethernet controller: PCI device 1186:1300 (D-Link System Inc) (rev
16).
      IRQ 15.
      Master Capable.  Latency=66.  Min Gnt=32.Max Lat=64.
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0xb0800000 [0xb08000ff].


On Thu, 2002-03-07 at 10:19, Masoud Sharbiani wrote:
> Hi,
> D-Link 530TX driver is actually via-rhine, not 8139too. Have you tried that
> one?
> 
> 
> Masoud
> --
> Masoud Sharabiani
> Software Developer, OEone Corporation
> #103 - 290 St-Joseph Blvd.  Hull, Quebec J8Y 3Y3
> 
> 
> 


