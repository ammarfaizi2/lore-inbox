Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbREOUHI>; Tue, 15 May 2001 16:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbREOUG6>; Tue, 15 May 2001 16:06:58 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261425AbREOUGk>; Tue, 15 May 2001 16:06:40 -0400
Message-ID: <3B018C42.B27A05E@transmeta.com>
Date: Tue, 15 May 2001 13:06:26 -0700
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
> > Don't get boxed in by thinking that you only have one fd. Even if you have
> > only one _device_node_, you can have multiple fd's. In fact, you can, with
> > the Linux VFS layer, fairly easily do things like
> >
> >       mknod /dev/fd0 c X Y
> >
> > and then use
> >
> >       fd = open("/dev/fd0/colourspace", O_RDWR);
> 
> Yipes!! I have to say UNIX has a tendency to teach you ioctl is the only
> way. I have never thought outside of the box nor see anyone else in this
> manner. This is absolutely brillant!!! I can see alot of possibilties with
> this.
> 

I actually suggested something like this a while ago, mainly w.r.t. how
to deal with serial ports (e.g. /dev/ttyS0/callout instead of /dev/cua0).

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
