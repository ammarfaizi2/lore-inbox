Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSLKUAB>; Wed, 11 Dec 2002 15:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267213AbSLKUAA>; Wed, 11 Dec 2002 15:00:00 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:53121 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266638AbSLKT74>;
	Wed, 11 Dec 2002 14:59:56 -0500
Date: Wed, 11 Dec 2002 21:04:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>,
       Petr Sebor <petr@scssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE feature request & problem
Message-ID: <20021211210416.A506@ucw.cz>
References: <068d01c29d97$f8b92160$551b71c3@krlis><1039312135.27904.11.camel@irongate.sw <021401c2a05d$f1c72c80$551b71c3@krlis> <1039540202.14251.43.camel@irongate.swansea.linux.org.uk> <039d01c2a0ab$b19a5ad0$551b71c3@krlis> <1039569643.14166.105.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1039569643.14166.105.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 11, 2002 at 01:20:43AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 01:20:43AM +0000, Alan Cox wrote:
> On Wed, 2002-12-11 at 00:24, Milan Roubal wrote:
> > Hi Alan,
> > I have got xfs partition and man fsck.xfs say
> > that it will run automatically on reboot.
> 
> You need to force one. Something (I assume XFS) asked the disk for a
> stupid sector number. Thats mostly likely due to some kind of internal
> corruption on the XFS

Or the power supply doesn't give enough power to the drives anymore (my
350W PSU is having heavy problems with five or more drives), and the IDE
transfers get garbled. Note that there is no CRC protection for non-data
xfers even when UDMA is in use, which includes LBA sector addressing.

-- 
Vojtech Pavlik
SuSE Labs
