Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbRGNRjU>; Sat, 14 Jul 2001 13:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264489AbRGNRjK>; Sat, 14 Jul 2001 13:39:10 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63651 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264432AbRGNRjB>;
	Sat, 14 Jul 2001 13:39:01 -0400
Message-ID: <3B5083AE.71515696@mandrakesoft.com>
Date: Sat, 14 Jul 2001 13:38:54 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: (patch-2.4.6) Fix oops with Iomega Clik! (ide-floppy)
In-Reply-To: <E15LTIY-0001Ul-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Jeff Garzik wrote:
> > it would be nice to remove __KERNEL__ from at least the i386
> > kernel headers in 2.5, and I think it's a doable task...
> 
> That just generates work for the glibc folks when they are working off copies
> of kernel header snapshots as they need to

It is a flag day change so it generates [a lot of] work once... it has
always been policy that userspace shouldn't be including kernel
headers.  uClibc and now dietlibc are following this policy.

IMHO we have made an exception for glibc for long enough...

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
