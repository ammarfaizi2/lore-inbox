Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264319AbTDKH43 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTDKH42 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:56:28 -0400
Received: from ovh.tbs-internet.com ([213.186.35.102]:35467 "EHLO
	www.TBS-satellite.com") by vger.kernel.org with ESMTP
	id S264319AbTDKH40 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 03:56:26 -0400
From: Francis Galiegue <fg6@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP stack related prob.
Date: Fri, 11 Apr 2003 10:08:15 +0200
User-Agent: KMail/1.5
References: <20030411073848.33517.qmail@web20106.mail.yahoo.com> <1050047551.1415.4.camel@laptop.fenrus.com>
In-Reply-To: <1050047551.1415.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304111008.16700.fg6@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 April 2003 09:52, Arjan van de Ven wrote:
> On Fri, 2003-04-11 at 09:38, Alisha Nigam wrote:
> >  then compile it
> >   gcc -c -O -W -Wall -Wstrict-prototypes
> > -Wmissing-prototypes -DMODULE -D__KERNEL__ -mymodule.o
> > mymodule.c
> >
> >
> >    i am getting a bundle of errors ......
> >
> >
> > In file included from /usr/include/linux/fs.h:23,
> >                  from
> > /usr/include/linux/capability.h:17,
> >                  from /usr/include/linux/binfmts.h:5,
> >                  from /usr/include/linux/sched.h:9,
> >                  from /usr/include/linux/skbuff.h:19,
> >                  from p10.c:2:
> > /usr/include/linux/string.h:8:2: warning: #warning
> > Using kernel header in userland!
>
> you are using glibc headers to compile a kernel.... that's not going to
> work. Add -I/lib/modules/`uname -r`/build/include to the gcc commandline
> to use the headers of the currently running kernel..

Not only that but aren't modules supposed to be compiled with -O2?

-- 
Francis Galiegue <fgaliegue@tbs-internet.com>
"98% of DNS Queries at the Root Level are Unnecessary" - Slashdot headline
"Scientists at the Vatican Praying Center found that 98% of the prayer queries
at the God level are unnecessary." - Anonymous Coward

