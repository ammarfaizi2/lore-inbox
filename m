Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319499AbSIGSX2>; Sat, 7 Sep 2002 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319441AbSIGSX2>; Sat, 7 Sep 2002 14:23:28 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:35337
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319499AbSIGSX1>; Sat, 7 Sep 2002 14:23:27 -0400
Date: Sat, 7 Sep 2002 11:26:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops
In-Reply-To: <1031421665.14390.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10209071125500.16589-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks like he has both modules loaded and not as built-ins.

On 7 Sep 2002, Alan Cox wrote:

> On Sat, 2002-09-07 at 17:37, Bob McElrath wrote:
> > Kernel 2.4.20-pre5-ac4 with the latest ACPI patches gives me an oops any
> > time I try to access the CD-ROM:
> > 
> > Note this also happened with pre4-ac1 so I don't think it's due to the
> > latest IDE merge in pre5-ac4.
> 
> Yes. What were you doing to trigger it. Also do you have highio/highmem
> stuff enabled and is taskfile on or off ?
> 
> I'm having real trouble reproducing this problem although enough people
> see it thats its clearly quite real
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

