Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSADMUo>; Fri, 4 Jan 2002 07:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288618AbSADMU3>; Fri, 4 Jan 2002 07:20:29 -0500
Received: from ns.suse.de ([213.95.15.193]:65295 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288615AbSADMUJ>;
	Fri, 4 Jan 2002 07:20:09 -0500
Date: Fri, 4 Jan 2002 13:20:07 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alex <mail_ker@xarch.tu-graz.ac.at>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.10.10201041306520.16087-100000@xarch.tu-graz.ac.at>
Message-ID: <Pine.LNX.4.33.0201041317470.18539-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Alex wrote:

> Maybe the best thing would be to supply the kernel a "large" _textfile_
> with all the hardware the user definitely has (at such-and such
> irq/dma/io); the textfile could be the output resilt from a
> "userfriendly" hardware-detection tool that lists all categories of
> hardwares etc. and has - generally - a large hardware database.

Think about ancient hardware (Yes theres lots of it still in use)
These beasts had jumpers to set IRQ/DMA etc, and this was not detectable
from software until PNPISA arrived on the scene.

You're still going to need user interaction for a lot of these.

"But Microsoft doesn't" isn't an argument any more either, they dropped
support for really ancient hardware a long time ago.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

