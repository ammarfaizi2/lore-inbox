Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbRLXW5G>; Mon, 24 Dec 2001 17:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283467AbRLXW44>; Mon, 24 Dec 2001 17:56:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:20230
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S283268AbRLXW4s>; Mon, 24 Dec 2001 17:56:48 -0500
Date: Mon, 24 Dec 2001 14:55:54 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Stanislav Meduna <stano@meduna.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE CDROM locks the system hard on media error
In-Reply-To: <200112242137.fBOLbcU08347@meduna.org>
Message-ID: <Pine.LNX.4.10.10112241455260.14431-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Only in UltraDMA for all devices.
Switch to MWDMA2 and it is all cool.

On Mon, 24 Dec 2001, Stanislav Meduna wrote:

> Hello,
> 
> > If it is DMAing and there is a 1us transaction delay it is toast.
> 
> Oh... But why does the whole kernel lock up?
> 
> > Intel PIIX4 AB/EB is a NO-NO for doing ATAPI on.
> 
> Only when using DMA or generally?
> 
> Maybe there should be some "quirk" disallowing this or at least
> warn when the user happens to select this?
> 
> Regards
> -- 
>                                       Stano
> 

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

