Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbREOUFs>; Tue, 15 May 2001 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbREOUFi>; Tue, 15 May 2001 16:05:38 -0400
Received: from zeus.kernel.org ([209.10.41.242]:14534 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261424AbREOUF3>;
	Tue, 15 May 2001 16:05:29 -0400
Date: Tue, 15 May 2001 13:03:46 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What Al is saying, and what makes perfect sense is that you generate a
> separate fd for each "pipe". It's even more obvious in the case of USB,
> because, by golly, the things are actually _called_ "pipes" in the USB
> documentation, which should have made people make the immediate
> association. Instead of doing

Graphics cards are the same way. Especially high end ones. They have pipes
as well. For low end cards you can think of them as single pipeline cards
with one pipe.

> See? 
> 
> Don't get boxed in by thinking that you only have one fd. Even if you have
> only one _device_node_, you can have multiple fd's. In fact, you can, with
> the Linux VFS layer, fairly easily do things like
> 
> 	mknod /dev/fd0 c X Y
> 
> and then use
> 
> 	fd = open("/dev/fd0/colourspace", O_RDWR);

Yipes!! I have to say UNIX has a tendency to teach you ioctl is the only
way. I have never thought outside of the box nor see anyone else in this
manner. This is absolutely brillant!!! I can see alot of possibilties with
this. 


