Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQKQJAe>; Fri, 17 Nov 2000 04:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130195AbQKQJAY>; Fri, 17 Nov 2000 04:00:24 -0500
Received: from xerxes.thphy.uni-duesseldorf.de ([134.99.64.10]:4329 "EHLO
	xerxes.thphy.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S130180AbQKQJAQ>; Fri, 17 Nov 2000 04:00:16 -0500
Date: Fri, 17 Nov 2000 09:30:13 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: "SubmittingPatches" text
In-Reply-To: <200011162132.PAA01944@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10011170927000.20243-100000@chaos.thphy.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2000, Jeff Garzik wrote:

> To create a patch for a single file, it is often sufficient to do:
> 
> 	SRCTREE=/usr/src/linux
> 	MYFILE=drivers/net/mydriver.c
> 
> 	cd $SRCTREE
> 	cp $MYFILE $MYFILE.orig
> 	vi $MYFILE	# make your change
> 	diff -u $MYFILE.orig $MYFILE > /tmp/patch

One question comes to my mind: Are patches supposed to be applied with
patch -p0 or patch -p1? 

AFAIU, the preferred way is -p1, but the above example would need -p0, if
I'm not mistaken. So that'ld make it harder than necessary to collect
patches and then apply the whole set, which seems to be Linus' preferred
way.

--Kai

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
