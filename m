Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318323AbSHEG4I>; Mon, 5 Aug 2002 02:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSHEG4I>; Mon, 5 Aug 2002 02:56:08 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1541 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S318323AbSHEG4H>; Mon, 5 Aug 2002 02:56:07 -0400
Date: Sun, 4 Aug 2002 23:52:11 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 IDE Partition Check issue 
In-Reply-To: <200208050241.g752fBC12491@verdi.et.tudelft.nl>
Message-ID: <Pine.LNX.4.10.10208042350020.11932-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Rob van Nieuwkerk wrote:

> 
> Alan wrote:
> > The Promise stuff is fixed in -ac and was exactly this issue. LBA48 is
> > not supported by the earlier promise controllers. The highpoint may well
> 
> Hi Alan,
> 
> I planned to do a massive disk replace/relocate action on my machines
> soon and part of the plan is having a 160GB Maxtor in some machines.
> Got scared by statement above .. :-)
> 
> I got myself a 2.4.19-ac3 tree, looked around in the IDE code and wasn't
> able to find the answer for my questions:
> 
> Any chance of lba48 working on a:
> 
>     - Promise Ultra66 (PDC20262: chipset revision 1) ?

Yes if BIOS is updated.

>     - Intel 82371AB PIIX4 IDE (rev 01) (On P-III BX-chipset mobo) ?

Yes confirmed from Intel, their T13 representative.

>     - Intel 82371FB PIIX IDE [Triton I] (rev 02) (On P-I Triton I mobo) ?

NO confirmed from Intel, their T13 representative, untested in Linux

> 	greetings,
> 	Rob van Nieuwkerk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

