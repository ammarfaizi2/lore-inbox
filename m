Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTBUVDI>; Fri, 21 Feb 2003 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267668AbTBUVDI>; Fri, 21 Feb 2003 16:03:08 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:4051 "EHLO
	mail41.fg.online.no") by vger.kernel.org with ESMTP
	id <S267560AbTBUVDH>; Fri, 21 Feb 2003 16:03:07 -0500
Date: Fri, 21 Feb 2003 22:13:08 +0100
From: Dag Bakke <cheapisp@sensewave.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 series IDE troubles
Message-ID: <20030221211308.GL19846@dagb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2003 18:59:40 +0000, Alan Cox wrote:
> With 2.4.21pre (the firs 2.4 IDE I hacked on seriously) pcmcia flash 
> works on my test setups, and gets used fairly hard for digital cameras

Anyone tried booting a  recent Toshiba Laptop from PCMCIA?
I have, and it doesn't work. Not that this necessarily has anything to do
with the IDE code. I have tried both recent -ac and vanilla.     

In short, if I load the kernel from PCMCIA, the CardBus slots disappear
from the PCI bus. -> no root device -> boom!

If I load the kernel from any other medium (haven't tried PCMCIA netboot),
the CardBus slots are present.

Is this a Toshiba oddity for which there isn't a PCI quirk yet?
Any suggestions for debugging?

Dag B.
