Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129688AbRBIQdK>; Fri, 9 Feb 2001 11:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbRBIQdA>; Fri, 9 Feb 2001 11:33:00 -0500
Received: from zeus.kernel.org ([209.10.41.242]:48835 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129688AbRBIQcv>;
	Fri, 9 Feb 2001 11:32:51 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Fri, 9 Feb 2001 17:29:52 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PC
CC: linux-kernel@vger.kernel.org, gandalf@winds.org
X-mailer: Pegasus Mail v3.40
Message-ID: <1500B3C52526@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Feb 01 at 16:58, Vojtech Pavlik wrote:

> Unfortunately the PCI speed measuring code needs help from the chipset
> itself, so it isn't possible to implement in generic code. Maybe a
> callback could be added to the chipset-specific drivers, though ...
> 
> I do have some plans with ide-pci.c, so ...

Is not PCI speed determined by host-bridge setting (and not by IDE 
interface)? In that case we should determine bus speed on PCI bus scan 
using chipset specific drivers. Other non IDE devices, such as matroxfb, 
may be interested in PCI speed too.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
