Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbREOUS2>; Tue, 15 May 2001 16:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbREOUSS>; Tue, 15 May 2001 16:18:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:30471 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261431AbREOUSI>; Tue, 15 May 2001 16:18:08 -0400
Message-ID: <3B018ECF.A9FEAE8@transmeta.com>
Date: Tue, 15 May 2001 13:17:19 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151151380.22038-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> >
> >       fd = open("/dev/fd0/colourspace", O_RDWR);
> 
> Yipes!! I have to say UNIX has a tendency to teach you ioctl is the only
> way. I have never thought outside of the box nor see anyone else in this
> manner. This is absolutely brillant!!! I can see alot of possibilties with
> this.
> 

By the way, since this is of general interest...

I asked the POSIX people if there was anything in the Austin (Unix 2002)
draft that would prohibit this behaviour.  The response was more or less
of the form "we are not really sure if it's within the spec, but it is
perfectly reasonable."  The (only) issue seems to be whether or not the
requirement to deliver ENOTDIR in cases like this is absolute or if this
is a permissible extension.  The way I interpret what I got back was
pretty much "go for it and don't worry about it."

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
