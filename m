Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261982AbREPPMA>; Wed, 16 May 2001 11:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261981AbREPPLu>; Wed, 16 May 2001 11:11:50 -0400
Received: from comverse-in.com ([38.150.222.2]:51198 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261978AbREPPLk>; Wed, 16 May 2001 11:11:40 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678ED1@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'H. Peter Anvin'" <hpa@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chip Salzenberg <chip@valinux.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: RE: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 11:06:55 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, even if you spank the future violators, what about the current
overlaps?
E.g., the CD-ROM ioctls are overlapping
with the STREAMS ioctls (the latter ones used by LiS and honored by glibc).

V.

> -----Original Message-----
> From: H. Peter Anvin [mailto:hpa@transmeta.com]
> Alan Cox wrote:
> > 
> > > 1. is of course a problem in itself.  Someone who creates 
> overlapping
> > > ioctls should be spanked, hard.
> > 
> > No argument there. But there is no LANANA ioctl body
> > 
> 
> I though Michael Chastain was maintaining this set.  No, we 
> haven't made
> it an official LANANA function, mostly because I didn't want to push.
