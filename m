Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbREOUbS>; Tue, 15 May 2001 16:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbREOUbJ>; Tue, 15 May 2001 16:31:09 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261456AbREOUay>; Tue, 15 May 2001 16:30:54 -0400
Message-ID: <3B0191E5.508CAB9@transmeta.com>
Date: Tue, 15 May 2001 13:30:29 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: James Simmons <jsimmons@transvirtual.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151607100.21081-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 15 May 2001, James Simmons wrote:
> 
> > > only one _device_node_, you can have multiple fd's. In fact, you can, with
> > > the Linux VFS layer, fairly easily do things like
> > >
> > >     mknod /dev/fd0 c X Y
> > >
> > > and then use
> > >
> > >     fd = open("/dev/fd0/colourspace", O_RDWR);
> >
> > Yipes!! I have to say UNIX has a tendency to teach you ioctl is the only
> > way. I have never thought outside of the box nor see anyone else in this
> > manner. This is absolutely brillant!!! I can see alot of possibilties with
> > this.
> 
> The thing being, why thet hell create these device/directory hybrids?
> 

Permission management.  The permissions on the subnodes are inherited
from the main node, which is stored on a persistent medium.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
