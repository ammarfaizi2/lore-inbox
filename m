Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288708AbSADSLg>; Fri, 4 Jan 2002 13:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288710AbSADSL1>; Fri, 4 Jan 2002 13:11:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56488 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288708AbSADSLK>;
	Fri, 4 Jan 2002 13:11:10 -0500
Date: Fri, 4 Jan 2002 13:11:05 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Nikita Danilov <Nikita@Namesys.COM>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, andries.brouwer@cwi.nl
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <Pine.LNX.4.33.0201040953040.5360-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0201041308380.26982-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Linus Torvalds wrote:

> 
> On Fri, 4 Jan 2002, Jeff Garzik wrote:
> >
> > As mentioned to viro on IRC, I think init_special_inode should take
> > major and minor arguments, to nudge the filesystem implementors into
> > thinking that major and minor should be treated separately, and be given
> > additional thought as to how they are encoded on-disk.
> 
> Yes. If somebody sends me a patch, I'll apply it in a jiffy.

Guys, wait a minute with that.  There is a related issue (->i_rdev
becoming dev_t) and I'd rather see it handled first.

