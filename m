Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264467AbRFOS0T>; Fri, 15 Jun 2001 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264470AbRFOS0J>; Fri, 15 Jun 2001 14:26:09 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:24511 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S264467AbRFOS0C>; Fri, 15 Jun 2001 14:26:02 -0400
Message-Id: <5.1.0.14.2.20010615192508.00afe540@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 15 Jun 2001 19:26:16 +0100
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: RE2: kmalloc
Cc: "Michael Nguyen" <mnguyen@ariodata.com>,
        "David S. Miller" <davem@redhat.com>,
        "Petko Manolov" <pmanolov@Lnxw.COM>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010615145856.C960@conectiva.com.br>
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com>
 <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:58 15/06/2001, Arnaldo Carvalho de Melo wrote:
>Em Fri, Jun 15, 2001 at 10:41:59AM -0700, Michael Nguyen escreveu:
> > >>Petko Manolov writes:
> > >> kmalloc fails to allocate more than 128KB of
> > >> memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
> > >>
> > >> Any ideas?
> >
> > >Yes, this is the limit.
> >
> > Im relatively new to Linux. I would like to ask.
> > Is this limit per kmalloc()? Can I do this multiple times?
>
>the limit is for a single invocation of kmalloc, yes, you can do it multiple
>times.

But if you need that much memory it would be better that you use vmalloc AFAIK.

Cheers,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

