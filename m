Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbREOWJs>; Tue, 15 May 2001 18:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbREOWJi>; Tue, 15 May 2001 18:09:38 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:54009 "EHLO tytlal")
	by vger.kernel.org with ESMTP id <S261637AbREOWJa>;
	Tue, 15 May 2001 18:09:30 -0400
Date: Tue, 15 May 2001 15:07:57 -0700
From: Chip Salzenberg <chip@valinux.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515150757.M3098@valinux.com>
In-Reply-To: <Pine.GSO.4.21.0105151746320.22958-100000@weyl.math.psu.edu> <3B01A649.A51E54DE@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3B01A649.A51E54DE@transmeta.com>; from hpa@transmeta.com on Tue, May 15, 2001 at 02:57:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to H. Peter Anvin:
> A device can inherently belong to multiple device classes, and it
> really should be thought of as such.

And then there are layering technologies like LVM and loopback.
They should be included in a discovery, but if you limit yourself
to one "device type", there's no place for them.

> For example a disk may belong, at the same time, to the "scsi",
> "disk" and "scsi-disk" device classes [...]

True, but in a sane system, "scsi" + "disk" implies "scsi-disk".
-- 
Chip Salzenberg              - a.k.a. -             <chip@valinux.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech
