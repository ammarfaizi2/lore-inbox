Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262777AbREOPRM>; Tue, 15 May 2001 11:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262779AbREOPRC>; Tue, 15 May 2001 11:17:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:53258 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262777AbREOPQv>; Tue, 15 May 2001 11:16:51 -0400
Date: Tue, 15 May 2001 08:16:31 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alexander Viro <viro@math.psu.edu>, Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zbU2-0002IF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105150815570.1802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 May 2001, Alan Cox wrote:
> 
> Counter argument; We dont want the bloat of making a floppy tape have
> delusions of grandeur in kernel space when mt-st can do it in userspace.

Counter-counter-argument: we could just export the ioctl's, and make a
"user-level-filesystem". Except it's not a filesystem, but a driver.

		Linus

