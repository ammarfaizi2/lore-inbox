Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262004AbRETABw>; Sat, 19 May 2001 20:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262008AbRETABm>; Sat, 19 May 2001 20:01:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50878 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262004AbRETABe>;
	Sat, 19 May 2001 20:01:34 -0400
Date: Sat, 19 May 2001 20:01:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device
 Number Registrants]
In-Reply-To: <20010519211717.A7961@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0105191958090.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Pavel Machek wrote:

> I thought about how to do networking without sockets, and it seems to
> me like this kind of modify syscall is needed, because network sockets
> connect to *two* different places (one local address and one
> remote). Sockets are really nasty :-(.

Pavel, take a look at http://plan9.bell-labs.com/sys/man/3/ip

