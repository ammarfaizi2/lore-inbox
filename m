Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbRBAJpl>; Thu, 1 Feb 2001 04:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130266AbRBAJpb>; Thu, 1 Feb 2001 04:45:31 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:61444 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130021AbRBAJpM>; Thu, 1 Feb 2001 04:45:12 -0500
Date: Thu, 1 Feb 2001 03:44:41 -0600
To: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Andries.Brouwer@cwi.nl,
        mlord@pobox.com, ole@linpro.no, linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
Message-ID: <20010201034441.A27725@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.10.10101310936280.14252-100000@master.linux-ide.org> <m3u26ffrej.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <m3u26ffrej.fsf@localhost.localdomain>; from rupa-list+linux-kernel@rupa.com on Wed, Jan 31, 2001 at 11:33:24AM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Rupa Schomaker]
> In my case, I have two identical Maxtor drives, but they reported
> different geometry.
[...]
> I'm doing RAID1 and it is really nice to have the same geometry so
> that the partition info is the same between the two drives.  Makes
> life easier.

If that's what you needed, you could have used 'dd' to copy the
partition table from one drive to the other.  Easier than going in and
re-cabling just to fool your BIOS.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
