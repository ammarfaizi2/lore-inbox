Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281349AbRKMAs3>; Mon, 12 Nov 2001 19:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281354AbRKMAsU>; Mon, 12 Nov 2001 19:48:20 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:49309 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281326AbRKMAsI>; Mon, 12 Nov 2001 19:48:08 -0500
Message-Id: <5.1.0.14.2.20011113004430.03264ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 13 Nov 2001 00:47:45 +0000
To: Alexander Viro <viro@math.psu.edu>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Cc: Andreas Gruenbacher <ag@bestbits.at>, Nathan Scott <nathans@sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu
 >
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:32 13/11/01, Alexander Viro wrote:
>On Mon, 12 Nov 2001, Andreas Gruenbacher wrote:
> > There is one difference between the interfaces you are complaining about
> > above and the proposed EA interface for EA's: In those interfaces you have
> > wildcard parameters that are used for who-knows-what, depending on a
> > command-like parameter, including use as a value, use as a pointer to a
> > value/struct, etc.
>
>Yes, and?  You've got more than enough material for the same kind of
>abuse.  What's more, you _already_ have it - in some of the subfunctions
>*data is read from, in some - written to, in some - ignored.  Worse
>yet, in some subfunctions we put structured data in there, in some -
>just a chunk of something.
>
>With all that, who had said that a year down the road we won't get a
>dozen of new syscalls hiding behind that one?
>
>Sorry, folks, but idea of private extendable syscall table (per-filesystem,
>no less) doesn't look like a good thing.  That's _the_ reason why ioctl()
>is bad.

Al,

Out of interest, which access interface(s) would you like to see used?

Giving a few suggestions you would be happy with would be a lot easier on 
anyone trying to develop a filesystem API than for them having to come up 
with one after the other until one is found which you approve of... (-;

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

