Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbREOVYS>; Tue, 15 May 2001 17:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbREOVYM>; Tue, 15 May 2001 17:24:12 -0400
Received: from [206.14.214.140] ([206.14.214.140]:3079 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261558AbREOVWr>; Tue, 15 May 2001 17:22:47 -0400
Date: Tue, 15 May 2001 14:22:26 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151328160.2470-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10105151418160.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I want to ease people into this notion. I'm personally perfectly happy to
> make it a real filesystem, if you are willing to write the code. But I've
> become convinced that the transition has to be really simple, with no
> administrative work.

Just one thing. Since we would end up with a system where each device is a
filesystem of some type how does this fit into devfs. I can't imagine
having a fstab file with 20 some filesystems for different types of
devices. I like to see the ability to mount device filesystems but I like
to have them all mounted at one time at boot time. Of course their might
be some users who don't feel this way. They might want to count what gets
mounted where. I guess devfsd could be expaned to handle this.

