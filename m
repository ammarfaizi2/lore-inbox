Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317730AbSHGN1r>; Wed, 7 Aug 2002 09:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317893AbSHGN1q>; Wed, 7 Aug 2002 09:27:46 -0400
Received: from pD9E6AD6C.dip.t-dialin.net ([217.230.173.108]:43851 "EHLO
	fefe.de") by vger.kernel.org with ESMTP id <S317730AbSHGN1p>;
	Wed, 7 Aug 2002 09:27:45 -0400
Date: Wed, 31 Jul 2002 18:59:41 +0200
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Asus A7V333: PCI_GOBIOS and PCI_GODIRECT disagree on one device
Message-ID: <20020731165941.GA3877@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what PCI_GODIRECT says:

  Bus  0, device   7, function  0:
    FireWire (IEEE 1394): PCI device 100c:8026 (Tseng Labs Inc) (rev 0).
      Master Capable.  Latency=16.
      Non-prefetchable 32 bit memory at 0x0 [0x7ff].
      Non-prefetchable 32 bit memory at 0x0 [0xffffffff].
      Non-prefetchable 32 bit memory at 0x0 [0xffffffff].

This is what PCI_GOBIOS says:

  Bus  0, device   7, function  0:
    FireWire (IEEE 1394): PCI device 104d:8026 (Sony Corporation) (rev 0).
      Master Capable.  Latency=16.
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0xffffffff].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x3].
      Non-prefetchable 64 bit memory at 0x0 [0xffffffff].

This appears to be the only device where both methods differ.  The
IEEE device is not detected under Windows either.  Is my mainboard
broken?

Felix
