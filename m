Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbREOWu3>; Tue, 15 May 2001 18:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbREOWuS>; Tue, 15 May 2001 18:50:18 -0400
Received: from [206.14.214.140] ([206.14.214.140]:4872 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261682AbREOWuE>; Tue, 15 May 2001 18:50:04 -0400
Date: Tue, 15 May 2001 15:49:31 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Chip Salzenberg <chip@valinux.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515144020.H3098@valinux.com>
Message-ID: <Pine.LNX.4.10.10105151546210.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> According to Alan Cox:
> > Given a file handle 'X' how do I find out what ioctl groups I should
> > apply to it.
> 
> Wouldn't it be better just to *try* ioctls and see which ones work and
> which ones don't?

You can do this with the tty layer. Just open /dev/tty and try tioclinux. 
On my serial console it fails and when I run the exact same program works
on my VT. It is the only way to see if these ioctl calls work. No other
way to see if your on a serial console or a VT. 

