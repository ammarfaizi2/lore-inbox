Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTACKWA>; Fri, 3 Jan 2003 05:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTACKWA>; Fri, 3 Jan 2003 05:22:00 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:62982
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267472AbTACKWA>; Fri, 3 Jan 2003 05:22:00 -0500
Date: Fri, 3 Jan 2003 02:29:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: John Bradford <john@grabjohn.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lionel.Bouton@inet6.fr,
       Teodor.Iacob@astral.kappa.ro, linux-kernel@vger.kernel.org
Subject: Re: IDE termination (was Re: UDMA 133 on a 40 pin cable)
In-Reply-To: <200301031020.h03AKV6N000674@darkstar.example.net>
Message-ID: <Pine.LNX.4.10.10301030225150.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, John Bradford wrote:

> > > I don't think ATA66+ controllers can be within spec if they don't detect 
> > > 40 vs 80 pin cables.
> > 
> > I wish. Alas not in the real world.
> 
> Something that occurs to me, which is somewhat related to this:
> 
> My understanding, (which might be wrong) is that termination of the
> IDE bus is partly handled by each connected devicem rather like modern
> floppy drives, (in contrast to SCSI, 10-base-2, old floppy drives etc,
> where the termination is handled by devices at the physical ends of
> the cable).
> 
> So if you connnect a really old IDE disk, say a 20 Mb one, and an
> ATA-100 one to the same bus, is the termination then out of spec,
> (analogous to using passive terminators on anything other than a SCSI-1
> bus), because presumably the termination requirements are stricter for
> the higher bus speed and signaling on both edges?

All are self terminating, and are effected by the M:S:C jumpers for
their responses.  Things like leak current times and other events that are
based on various decay rates against an assumed Z value for a given
ribbon+devices+host combination will change things rudely.

There are issues of shadow registers and pattern responses.

But you got the swing of it!

Cheers,

Andre Hedrick
LAD Storage Consulting Group

