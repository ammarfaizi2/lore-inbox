Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318861AbSHEUMq>; Mon, 5 Aug 2002 16:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318864AbSHEUMq>; Mon, 5 Aug 2002 16:12:46 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49157
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318861AbSHEUMk>; Mon, 5 Aug 2002 16:12:40 -0400
Date: Mon, 5 Aug 2002 13:08:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE udma_status = 0x76 and 2.5.30...
In-Reply-To: <20020804222542.GH13053@ppc.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208051249520.11932-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has now become an utter JOKE!

If we examine Table 2-3 of the Retired SFF-8038i rev 1.0 the only document
to describe the behaviors of Bus Master IDE Status Register.
It is a R/W field.

Bit 7: Simplex RO
Bit 6: Device 1 DMA Capable RW
Bit 5: Device 0 DMA Capable RW
Bit 4: Reserved "MUST RETURN ZERO ON READS" !!!		Vendor Write
Bit 3: Reserved "MUST RETURN ZERO ON READS" !!!		Vendor Write
Bit 2: Bus Master Interrupt	STATUS R Clear W
Bit 1: Bus Master Error		STATUS R Clear W
Bit 0: Bus Master Active	STATUS

Vendor Write, is not a published or listed techincal term.
It is me trying to present this clearly enough so that the masses will see
how poorly the general understanding of the basics in 2.5.

Not to worry, I am sure UnderDog will come an save the day soon enough.

Regards,

Andre Hedrick
LAD Storage Consulting Group

