Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTI3VaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 17:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbTI3VaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 17:30:01 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:6536 "EHLO alpha.stev.org")
	by vger.kernel.org with ESMTP id S261764AbTI3V3y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 17:29:54 -0400
Date: Tue, 30 Sep 2003 23:34:49 +0100 (BST)
From: James Stevenson <james@stev.org>
To: Kees Bakker <kees.bakker@xs4all.nl>
cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [2.6.0-test6] Scratchy sound with via82xx (VT8233)
In-Reply-To: <200309302046.47039.kees.bakker@xs4all.nl>
Message-ID: <Pine.LNX.4.44.0309302333100.19433-100000@jlap.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

i also see this in the 2.4.19 - 2.4.22 kernels
i have the following

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 30)
	Subsystem: AOPEN Inc.: Unknown device 006a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
	<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 12
	Region 0: I/O ports at e000 [size=256]
	Capabilities: <available only to root>

it plays fine then it starts scrathing then plays fine etc.. etc..

	James

On Tue, 30 Sep 2003, Kees Bakker wrote:

> Starting with 2.6.0-test6 the sound is (often) not OK. For example,
> I let KDE play a sound when email arrives. Often I only hear scratchy
> noise, but sometimes sound is OK.
> 
> The lcpci output for this device is:
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 10)
>         Subsystem: Micro-Star International Co., Ltd.: Unknown device 3800
>         Flags: medium devsel, IRQ 10
>         I/O ports at d000 [size=256]
>         Capabilities: [c0] Power Management version 2
> 
> I saw the note about dxs_support, but I have the driver built-in. How do I set
> dxs_support from the /proc/cmdline?
> 
> 		Kees
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

