Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbTBVIjn>; Sat, 22 Feb 2003 03:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267853AbTBVIjm>; Sat, 22 Feb 2003 03:39:42 -0500
Received: from mail44-s.fg.online.no ([148.122.161.44]:53898 "EHLO
	mail44.fg.online.no") by vger.kernel.org with ESMTP
	id <S267852AbTBVIjl>; Sat, 22 Feb 2003 03:39:41 -0500
Date: Sat, 22 Feb 2003 09:49:29 +0100
From: Dag Bakke <cheapisp@sensewave.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jonathan@buzzard.org.uk
Subject: Re: 2.4 series IDE troubles
Message-ID: <20030222084929.GA6009@dagb>
References: <20030221211308.GL19846@dagb> <1045871540.1630.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045871540.1630.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 11:52:21PM +0000, Alan Cox wrote:
> On Fri, 2003-02-21 at 21:13, Dag Bakke wrote:
> > On 21 Feb 2003 18:59:40 +0000, Alan Cox wrote:
> > > With 2.4.21pre (the firs 2.4 IDE I hacked on seriously) pcmcia flash 
> > > works on my test setups, and gets used fairly hard for digital cameras
> > 
> > Anyone tried booting a  recent Toshiba Laptop from PCMCIA?
> > I have, and it doesn't work. Not that this necessarily has anything to do
> > with the IDE code. I have tried both recent -ac and vanilla.     
> > 
> > In short, if I load the kernel from PCMCIA, the CardBus slots disappear
> > from the PCI bus. -> no root device -> boom!
> 
> Some toshiba stuff seems to hide the cardbus/pcmcia and fake the attached
> CD-ROM used for booting as a native IDE device. I assume this is for 
> windows 95/98 installation. Vaio's do something similar but do not hide
> the cardbus. When the cardbus is initialised on the vaio the magic IDE
> mapping vanishes
> 

I boot from CF in a PCMCIA sleeve. Sorry for not being clear about that.
But in any case:

even if these toshibas you mention above "fake the attached CD-ROM used for 
booting as a native IDE device", that IDE device has to be visible
after the operating system has initialized? Pretty hard to install anything
from CD-ROM otherwise...?

The way it looks to me, this is more a question about the PCI subsystem
in the toshiba.  Of course, I could be totally off base.

Anyone got any great ideas about how to beat the Toshiba into submission
and make it admit that it has the cardbus slots it just booted from?

Perhaps some poking in the magic registers of these animals?
(http://www.buzzard.org.uk/toshiba/docs.html)
Not sure if Jonathan still maintains the Toshiba utilities/docs, though.

Dag B

