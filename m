Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBJJFQ>; Sat, 10 Feb 2001 04:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbRBJJE4>; Sat, 10 Feb 2001 04:04:56 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:51207 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129664AbRBJJEr>;
	Sat, 10 Feb 2001 04:04:47 -0500
Date: Sat, 10 Feb 2001 10:03:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        gandalf@winds.org
Subject: Re: [preview] VIA IDE 4.0 and AMD IDE 2.0 with automatic PC
Message-ID: <20010210100320.B330@suse.cz>
In-Reply-To: <1500B3C52526@vcnet.vc.cvut.cz> <Pine.LNX.4.10.10102092206130.7400-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102092206130.7400-100000@master.linux-ide.org>; from andre@linux-ide.org on Fri, Feb 09, 2001 at 10:06:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 10:06:39PM -0800, Andre Hedrick wrote:

> > > Unfortunately the PCI speed measuring code needs help from the chipset
> > > itself, so it isn't possible to implement in generic code. Maybe a
> > > callback could be added to the chipset-specific drivers, though ...
> > > 
> > > I do have some plans with ide-pci.c, so ...
> > 
> > Is not PCI speed determined by host-bridge setting (and not by IDE 
> > interface)? In that case we should determine bus speed on PCI bus scan 
> > using chipset specific drivers. Other non IDE devices, such as matroxfb, 
> > may be interested in PCI speed too.
> 
> that file will most likely go away in 2.5

Good, it should.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
