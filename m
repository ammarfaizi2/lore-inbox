Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSLHSSh>; Sun, 8 Dec 2002 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSLHSSh>; Sun, 8 Dec 2002 13:18:37 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:34486 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S261495AbSLHSSh>;
	Sun, 8 Dec 2002 13:18:37 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/pci deprecation?
References: <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 07 Dec 2002 17:23:13 +0100
In-Reply-To: <Pine.LNX.4.33.0212061601550.1010-100000@localhost.localdomain>
Message-ID: <m34r9pkdce.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> IMO, yes, since those tools provide the summary, and exist almost purely 
> in userspace. I forgot to mention in the orginal email that we could 
> also drop the PCI names database, right? This would save a considerable 
> amount in the kernel image alone..

I think so.

BTW: the /proc/pci doesn't show names of CardBus adapters, even if they're
inserted at boot time - cat /proc/pci | tail:

    VGA compatible controller: Silicon Motion, Inc. SM720 Lynx3DM (rev 177).
      IRQ 10.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  2, device   0, function  0:
    Ethernet controller: PCI device 1011:0019 (rev 65).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=20.Max Lat=40.
      I/O at 0x4000 [0x407f].
      Non-prefetchable 32 bit memory at 0x10800000 [0x108003ff].
-- 
Krzysztof Halasa
Network Administrator
