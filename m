Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271441AbRHOU51>; Wed, 15 Aug 2001 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271446AbRHOU5S>; Wed, 15 Aug 2001 16:57:18 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:44713 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271441AbRHOU5O>; Wed, 15 Aug 2001 16:57:14 -0400
Message-Id: <5.1.0.14.2.20010815214832.00ab9c40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 15 Aug 2001 21:57:19 +0100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.8 Resource leaks + limits
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), mag@fbab.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15X74U-0003va-00@the-village.bc.nu>
In-Reply-To: <20010815215723.F9870@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:15 15/08/2001, Alan Cox wrote:
> > Not really. Large installations use ACLs instead of groups.
>
>Umm you can't use ACL's for resource management. You have to be able to
>charge an entity. Its not a permission to access, its a "who is paying" and
>that requires a real entity to charge to

While we are on this topic, wouldn't it make sense to introduce unique 
identifiers, which can be associated with users, groups, or any other 
kernel object for that matter, then this is the entity you charge. The 
kernel can then map the id to the user or group (or whatever object).

When ACLs are introduced they would grant/deny permissions and in general 
operate only on unique identifiers.

This would have the benefit that the identifiers can be made sufficiently 
unique to work on a whole network (or even larger scales), which would make 
user management much easier for large corporations, much akin to what 
Netware and Windows servers do in fact...

Just my 2p.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

