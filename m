Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030572AbWBNN7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030572AbWBNN7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 08:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbWBNN7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 08:59:01 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:50408 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030572AbWBNN7A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 08:59:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pfgk0pOnOD3v4b2Qkpe3i9gOd1Hp0oLL629YJ1wDl///33/7oKIURQBTgJj46DEq4o7cKZwABCSBulzMcMTJS9vaDN/eTtYDFv9HDpRAl0d5/nHLcV5aXuiyYsBruRzB0iTPDf/itYDCmirw8POM50FkbO+726lUWtszxT1AJtk=
Message-ID: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
Date: Tue, 14 Feb 2006 14:58:58 +0100
From: Lz <elezeta@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problems with sound on latest kernels.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't manage to get my sound cards (SB VIBRA and SB AWE 32) working
on the latest kernels (> 2.6.14 approximately).

They doesn't even work if i use an older .config from a 2.6.12 kernel
in which they worked. That's the weird thing.

These are the relevant lines on dmesg:

Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
pnp: AWE32 quirk - adding two ports
pnp: SB audio device quirk - increasing port range
isapnp: Card 'Creative SB AWE32 PnP'
isapnp: Card 'Creative ViBRA16C PnP'
isapnp: 2 Plug & Play cards detected total

sb: Init: Starting Probe...
sb: PnP: Found Card Named = "Creative SB AWE32 PnP", Card PnP id = CTL0042, Devi
ce PnP id = CTL0031
sb: PnP:      Detected at: io=0x0, irq=-1, dma=-1, dma16=-1
sb: ports busy.
sb: PnP: Found Card Named = "Creative ViBRA16C PnP", Card PnP id = CTL0070, Devi
ce PnP id = CTL0001
sb: PnP:      Detected at: io=0x0, irq=-1, dma=-1, dma16=-1
sb: ports busy.
sb: Init: Done

(Note that when they worked, the irq and dma were not -1).

Is there any fix around? :?

Thanks.

--
Lz (elezeta@gmail.com).
http://elezeta.bounceme.net
