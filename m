Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSDEAZk>; Thu, 4 Apr 2002 19:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSDEAZ3>; Thu, 4 Apr 2002 19:25:29 -0500
Received: from elin.scali.no ([62.70.89.10]:29710 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S290818AbSDEAZT>;
	Thu, 4 Apr 2002 19:25:19 -0500
Date: Fri, 5 Apr 2002 02:24:06 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Bill Davidsen <davidsen@tmr.com>,
        Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] compile error in 2.4.19-pre5-ac1 
In-Reply-To: <1928.1017965754@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.30.0204050220590.7535-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Keith Owens wrote:

> On Thu, 4 Apr 2002 18:45:24 -0500 (EST),
> Bill Davidsen <davidsen@tmr.com> wrote:
> >  Note of warning to new Redhat users, for some reason /usr/include/linux
> >is a directory instead of a symbolic link to /usr/src/linux/include/linux,
> >so changes in includes aren't used. Possibly an artifact of the install on
> >that system, but something to note.
>
> That is the way it is meant to be.  /usr/include/{linux,asm} do not
> point to some random kernel source, they are _copies_ of the kernel
> headers at the time that glibc was built and must not change until you
> install a new glibc.

Then it's a bit odd that RH ships a new kernel-headers RPM (which
contains the /usr/include/{linux,asm} directories) for each kernel
update and glibc still beeing the same, isn't it ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

