Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbREIT6w>; Wed, 9 May 2001 15:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbREIT6m>; Wed, 9 May 2001 15:58:42 -0400
Received: from feral.com ([192.67.166.1]:17448 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S130466AbREIT62> convert rfc822-to-8bit;
	Wed, 9 May 2001 15:58:28 -0400
Date: Wed, 9 May 2001 12:57:48 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
cc: Dan Hollis <goemon@anime.net>, Larry McVoy <lm@bitmover.com>,
        Marty Leisner <leisner@rochester.rr.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <Pine.LNX.4.10.10105091754210.1512-100000@linux.local>
Message-ID: <Pine.BSF.4.21.0105091257390.16361-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 May 2001, [ISO-8859-1] Gérard Roudier wrote:

> 
> 
> On Tue, 8 May 2001, Dan Hollis wrote:
> 
> > On Tue, 8 May 2001, Larry McVoy wrote:
> > > which is a text version of the paper I mentioned before.  The basic
> > > message of the paper is that it really doesn't help much to have things
> > > like ECC unless you can be sure that 100% of the rest of your system
> > > has similar checks.
> > 
> > UDMA has crc, scsi has parity, pci has (i think) parity, tcpip has crc,
> > your cpu l1 and l2 have ecc...
> 
> SCSI Ultra-160 has CRC.
> 
> PCI has parity (btw, you think right), but only a few drivers make sure
> PCI parity checking is enabled. On the other hand, a PCI parity error

Sun's panic if they get SERR or PERR.

> should be considered as extremally serious and the system should be
> stopped when such happens.
> 
> Btw, it seems (read at the pci list) that the original PCI hadn't parity.
> After all, PCI had been designed for PC machines... :)
> 
> > Looks like similar checks are already there.
> > 
> > -Dan
> > 
>   Gérard.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

