Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbREOVhS>; Tue, 15 May 2001 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbREOVhI>; Tue, 15 May 2001 17:37:08 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:2315 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261576AbREOVg7>; Tue, 15 May 2001 17:36:59 -0400
Date: Tue, 15 May 2001 14:36:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <344250272.989965778@[169.254.198.40]>
Message-ID: <Pine.LNX.4.21.0105151434530.2741-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alex Bligh - linux-kernel wrote:
> 
> Q: Let us assume you have dynamic numbering disk0..N as you suggest,
>    and you have some s/w RAID of SCSI disks. A disk fails, and is (hot)
>    removed. Life continues. You reboot the machine. Disks are now numbered
>    disk0..(N-1). If the RAID config specifies using disk0..N thusly,

If you have a raid config like that, then you're screwed _whatever_ you
do.

Look into using UUID's, which fix this properly.

And note, btw, how I think the md autorun stuff do all of this the RIGHT
way. Where RIGHT very much includes not using positional information etc.

		Linus

