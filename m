Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267744AbTBUWlM>; Fri, 21 Feb 2003 17:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267746AbTBUWlM>; Fri, 21 Feb 2003 17:41:12 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12928
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267744AbTBUWlM>; Fri, 21 Feb 2003 17:41:12 -0500
Subject: Re: 2.4 series IDE troubles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dag Bakke <cheapisp@sensewave.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030221211308.GL19846@dagb>
References: <20030221211308.GL19846@dagb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045871540.1630.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 21 Feb 2003 23:52:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 21:13, Dag Bakke wrote:
> On 21 Feb 2003 18:59:40 +0000, Alan Cox wrote:
> > With 2.4.21pre (the firs 2.4 IDE I hacked on seriously) pcmcia flash 
> > works on my test setups, and gets used fairly hard for digital cameras
> 
> Anyone tried booting a  recent Toshiba Laptop from PCMCIA?
> I have, and it doesn't work. Not that this necessarily has anything to do
> with the IDE code. I have tried both recent -ac and vanilla.     
> 
> In short, if I load the kernel from PCMCIA, the CardBus slots disappear
> from the PCI bus. -> no root device -> boom!

Some toshiba stuff seems to hide the cardbus/pcmcia and fake the attached
CD-ROM used for booting as a native IDE device. I assume this is for 
windows 95/98 installation. Vaio's do something similar but do not hide
the cardbus. When the cardbus is initialised on the vaio the magic IDE
mapping vanishes

