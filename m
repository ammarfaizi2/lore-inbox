Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135484AbREITX3>; Wed, 9 May 2001 15:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135296AbREITXT>; Wed, 9 May 2001 15:23:19 -0400
Received: from front5.grolier.fr ([194.158.96.55]:63112 "EHLO
	front5.grolier.fr") by vger.kernel.org with ESMTP
	id <S135266AbREITXC> convert rfc822-to-8bit; Wed, 9 May 2001 15:23:02 -0400
Date: Wed, 9 May 2001 18:11:15 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Dan Hollis <goemon@anime.net>
cc: Larry McVoy <lm@bitmover.com>, Marty Leisner <leisner@rochester.rr.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <Pine.LNX.4.30.0105082233430.30695-100000@anime.net>
Message-ID: <Pine.LNX.4.10.10105091754210.1512-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 May 2001, Dan Hollis wrote:

> On Tue, 8 May 2001, Larry McVoy wrote:
> > which is a text version of the paper I mentioned before.  The basic
> > message of the paper is that it really doesn't help much to have things
> > like ECC unless you can be sure that 100% of the rest of your system
> > has similar checks.
> 
> UDMA has crc, scsi has parity, pci has (i think) parity, tcpip has crc,
> your cpu l1 and l2 have ecc...

SCSI Ultra-160 has CRC.

PCI has parity (btw, you think right), but only a few drivers make sure
PCI parity checking is enabled. On the other hand, a PCI parity error
should be considered as extremally serious and the system should be
stopped when such happens.

Btw, it seems (read at the pci list) that the original PCI hadn't parity.
After all, PCI had been designed for PC machines... :)

> Looks like similar checks are already there.
> 
> -Dan
> 
  Gérard.

