Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTDKHyx (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTDKHyx (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:54:53 -0400
Received: from web20106.mail.yahoo.com ([216.136.226.43]:29841 "HELO
	web20106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264320AbTDKHyv (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 03:54:51 -0400
Message-ID: <20030411080633.36206.qmail@web20106.mail.yahoo.com>
Date: Fri, 11 Apr 2003 01:06:33 -0700 (PDT)
From: Alisha Nigam <mail_to_alisha@yahoo.com>
Subject: Re: TCP/IP stack related prob.
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1050047551.1415.4.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi 
   thanks a lot it compiled. but while inserting
module
with insmod i am getting errors..
   
   mymodule.o was compiler for kernel version 2.4.9-9
while this kernel is version 2.4.18-14.
 
     i am running RedHat-8.0  and  i compile it
including the headers of current running kernel as
mentioned by you only. 
   
   WHAT COULD BE THE PROBLEM ??????

--- Arjan van de Ven <arjanv@redhat.com> wrote:
> On Fri, 2003-04-11 at 09:38, Alisha Nigam wrote:
> 
> >  then compile it 
> >   gcc -c -O -W -Wall -Wstrict-prototypes
> > -Wmissing-prototypes -DMODULE -D__KERNEL__
> -mymodule.o
> > mymodule.c 
> > 
> > 
> >    i am getting a bundle of errors ...... 
> > 
> > 
> > In file included from /usr/include/linux/fs.h:23,
> >                  from
> > /usr/include/linux/capability.h:17,
> >                  from
> /usr/include/linux/binfmts.h:5,
> >                  from
> /usr/include/linux/sched.h:9,
> >                  from
> /usr/include/linux/skbuff.h:19,
> >                  from p10.c:2:
> > /usr/include/linux/string.h:8:2: warning: #warning
> > Using kernel header in userland!
> 
> you are using glibc headers to compile a kernel....
> that's not going to
> work. Add -I/lib/modules/`uname -r`/build/include to
> the gcc commandline
> to use the headers of the currently running kernel..
> 
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc



__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
