Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132616AbRAaUEE>; Wed, 31 Jan 2001 15:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRAaUDy>; Wed, 31 Jan 2001 15:03:54 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:24081
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S132630AbRAaUDk>; Wed, 31 Jan 2001 15:03:40 -0500
Date: Wed, 31 Jan 2001 12:03:04 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
cc: Andries.Brouwer@cwi.nl, mlord@pobox.com, ole@linpro.no,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <m3u26ffrej.fsf@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10101311201390.13711-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 2001, Rupa Schomaker wrote:

> Andre Hedrick <andre@linux-ide.org> writes:
> 
> 
> > > But there is no indication of what the problems could be,
> > > or what he thinks the geometry should be (and why).
> > > I see nothing very wrong in the posted data.
> > 
> > We agree Andries, but the enduser wants to see stuff the same.
> 
> In my case, I have two identical Maxtor drives, but they reported
> different geometry.  How could that be?  Move the "virgin" drive to
> the motherboard IDE controller and suddenly the geometry is the same.
> Use fdisk and partition the disk, write it, and then move to the
> promise controller and the "correct" geometry was used (that is, it is
> now the same as when hooked up to the motherboard ide controller).
> 
> Why was it important to me?  I'm doing RAID1 and it is really nice to
> have the same geometry so that the partition info is the same between
> the two drives.   Makes life easier.

Please read the above and pass the geometry to the kernel.
Mother boards have to do a translation to use the drive completely.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
