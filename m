Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283222AbRLDSfe>; Tue, 4 Dec 2001 13:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281647AbRLDSPe>; Tue, 4 Dec 2001 13:15:34 -0500
Received: from dsl-213-023-038-097.arcor-ip.net ([213.23.38.97]:40461 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S281533AbRLDSOu>;
	Tue, 4 Dec 2001 13:14:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux/Pro  -- clusters
Date: Tue, 4 Dec 2001 19:16:42 +0100
X-Mailer: KMail [version 1.3.2]
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), becker@scyld.com (Donald Becker),
        davidel@xmailserver.org (Davide Libenzi),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <E16BJvR-0002uc-00@the-village.bc.nu>
In-Reply-To: <E16BJvR-0002uc-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16BK7Y-0000Rk-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 4, 2001 07:04 pm, Alan Cox wrote:
> > Single additional alloc -> twice as many allocs, two slabs, more cachelines
> > dirty.  This was hashed out on fsdevel, though apparently not to everyone's
> > satisfaction.
> 
> Al Viro's NFS in generic_ip saved me something like 130K of memory.

Yes, all of these proposals would do that, by getting away from all inodes
being the same size (basically the size of the ext2 inode).

--
Daniel
