Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130624AbRBJGIQ>; Sat, 10 Feb 2001 01:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130958AbRBJGIH>; Sat, 10 Feb 2001 01:08:07 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:37894
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130624AbRBJGH7>; Sat, 10 Feb 2001 01:07:59 -0500
Date: Fri, 9 Feb 2001 22:06:39 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
        gandalf@winds.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PC
In-Reply-To: <1500B3C52526@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10102092206130.7400-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Petr Vandrovec wrote:

> On  9 Feb 01 at 16:58, Vojtech Pavlik wrote:
> 
> > Unfortunately the PCI speed measuring code needs help from the chipset
> > itself, so it isn't possible to implement in generic code. Maybe a
> > callback could be added to the chipset-specific drivers, though ...
> > 
> > I do have some plans with ide-pci.c, so ...
> 
> Is not PCI speed determined by host-bridge setting (and not by IDE 
> interface)? In that case we should determine bus speed on PCI bus scan 
> using chipset specific drivers. Other non IDE devices, such as matroxfb, 
> may be interested in PCI speed too.

that file will most likely go away in 2.5


Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
