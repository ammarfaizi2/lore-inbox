Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276187AbRI1RUa>; Fri, 28 Sep 2001 13:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276186AbRI1RUV>; Fri, 28 Sep 2001 13:20:21 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:41466 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S276184AbRI1RUJ>; Fri, 28 Sep 2001 13:20:09 -0400
Date: Fri, 28 Sep 2001 18:20:36 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Matt McLaughlin <darklord@velceroisp.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug Report.  Compiling probs w/ kernel 2.4.9
In-Reply-To: <Pine.SOL.3.96.1010928181306.11240D-100000@virgo.cus.cam.ac.uk>
Message-ID: <Pine.SOL.3.96.1010928181916.11240E-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should add that this has been fixed for ages and has been reported a
zillion times before. Checking the archives is always a good idea before
submitting bug reports for out of date kernels...

Anton

On Fri, 28 Sep 2001, Anton Altaparmakov wrote:

> On Fri, 28 Sep 2001, Matt McLaughlin wrote:
> 
> Correct solution.
> 
> Anton
> 
> > 
> >   To linux-kernel@vger.kernel.org:
> > 
> >   In trying to compile linux-2.4.9 with support for NTFS filesystem +w
> > perms.
> > Even though it is dangerous (supposevily) the kernel would still NOT
> > compile.
> > 
> >   So what I did to get it to compile was add '<linux/kernel.h>' to the
> > $kernel/fs/ntfs/unistr.c file.  Basically the only problem was that the
> > min(type,var1,var2) function was undeclared.
> > 
> >   Please make changes in the next release for future reference.  Thanks.
> > 
> >   -Matt 'DarkLord' McLaughlin
> > 
> >   Bio-Hazard Industries (c) 1994     darklord@velceroisp.com
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> Best regards,
> 
> 	Anton
> -- 
> Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
> Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
> ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

