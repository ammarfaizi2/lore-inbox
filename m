Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277379AbRJJTtu>; Wed, 10 Oct 2001 15:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277381AbRJJTtk>; Wed, 10 Oct 2001 15:49:40 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:52711 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S277379AbRJJTth>; Wed, 10 Oct 2001 15:49:37 -0400
Date: Wed, 10 Oct 2001 12:49:28 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: Wilson <defiler@null.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ATA/100 Promise Board
In-Reply-To: <04b601c151c2$1dd491a0$839183a0@W20303512>
Message-ID: <Pine.LNX.4.33.0110101239540.1192-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Wilson wrote:

> ----- Original Message -----
> From: "Joel Jaeggli" <joelja@darkwing.uoregon.edu>
> To: "Wilson" <defiler@null.net>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, October 10, 2001 3:20 PM
> Subject: Re: ATA/100 Promise Board
> >
> > I have three fasttrack 66's and one ultra100 in the same box... at present
> > it's out of pci slots, so I won't be adding more... ;)
> >
>
> Quoting from pdc202xx.c:
>
>  *  The latest chipset code will support the following ::
>  *  Three Ultra33 controllers and 12 drives.
>  *  8 are UDMA supported and 4 are limited to DMA mode 2 multi-word.
>  *  The 8/4 ratio is a BIOS code limit by promise.
>  *
>  *  UNLESS you enable "CONFIG_PDC202XX_BURST"
>
> Does this match your experiences with that many controllers in the same box?
> Thanks for the reply, by the way.

I don't have any of the ultra33 (20246) controllers... but I do have
CONFIG_PDC202XX_BURST set (ie. the "enabled special dma feature").
everything is more or less normal except that I think hdk in the box is
slowly dying at this point... this box has 8 drives on four controllers
rather than 12 on 3

hda: WDC AC22000L, ATA DISK drive
hdc: IBM-DTLA-307015, ATA DISK drive
hde: Maxtor 98196H8, ATA DISK drive
hdg: IBM-DTLA-307075, ATA DISK drive
hdi: WDC AC418000D, ATA DISK drive
hdk: WDC AC418000D, ATA DISK drive
hdm: WDC WD273BA, ATA DISK drive
hdo: WDC WD273BA, ATA DISK drive

>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.



