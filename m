Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132311AbRAaTd7>; Wed, 31 Jan 2001 14:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132401AbRAaTdt>; Wed, 31 Jan 2001 14:33:49 -0500
Received: from cx838204-a.alsv1.occa.home.com ([24.16.83.66]:3859 "HELO
	gw.rupa.com") by vger.kernel.org with SMTP id <S132311AbRAaTdm>;
	Wed, 31 Jan 2001 14:33:42 -0500
To: Andre Hedrick <andre@linux-ide.org>
Cc: Andries.Brouwer@cwi.nl, mlord@pobox.com, ole@linpro.no,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with Promise IDE controller under 2.4.1
In-Reply-To: <Pine.LNX.4.10.10101310936280.14252-100000@master.linux-ide.org>
From: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
Mail-Copies-To: never
Date: 31 Jan 2001 11:33:24 -0800
In-Reply-To: <Pine.LNX.4.10.10101310936280.14252-100000@master.linux-ide.org> (Andre Hedrick's message of "Wed, 31 Jan 2001 09:46:54 -0800 (PST)")
Message-ID: <m3u26ffrej.fsf@localhost.localdomain>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:


> > But there is no indication of what the problems could be,
> > or what he thinks the geometry should be (and why).
> > I see nothing very wrong in the posted data.
> 
> We agree Andries, but the enduser wants to see stuff the same.

In my case, I have two identical Maxtor drives, but they reported
different geometry.  How could that be?  Move the "virgin" drive to
the motherboard IDE controller and suddenly the geometry is the same.
Use fdisk and partition the disk, write it, and then move to the
promise controller and the "correct" geometry was used (that is, it is
now the same as when hooked up to the motherboard ide controller).

Why was it important to me?  I'm doing RAID1 and it is really nice to
have the same geometry so that the partition info is the same between
the two drives.   Makes life easier.

-- 
-rupa
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
