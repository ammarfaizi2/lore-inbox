Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRHST1H>; Sun, 19 Aug 2001 15:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270721AbRHST06>; Sun, 19 Aug 2001 15:26:58 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:61648 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S270717AbRHST0u>;
	Sun, 19 Aug 2001 15:26:50 -0400
Message-Id: <5.1.0.14.2.20010819202622.00ae28d0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 19 Aug 2001 20:26:54 +0100
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0
Cc: Chris Oxenreider <oxenreid@state.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20010819142008.C2580@conectiva.com.br>
In-Reply-To: <Pine.SV4.4.10.10108191150090.1226-100000@dorthy>
 <Pine.SV4.4.10.10108191150090.1226-100000@dorthy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:20 19/08/2001, Arnaldo Carvalho de Melo wrote:
>Em Sun, Aug 19, 2001 at 12:13:52PM -0500, Chris Oxenreider escreveu:
> >
> > Help.
> > On a freshly installed system using a version of Mandrake 8.0 from the
> > free 'iso' images on the linux-mandrake sight this is what happens:
>
>add
>
>#include <linux/kernel.h>

Yes, add above line to fs/ntfs/unistr.c and all is fine.

Anton


>IIRC this will do the trick, getting the min definition from kernel.h
>
>- Arnaldo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

