Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310231AbSCGWOi>; Thu, 7 Mar 2002 17:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310319AbSCGWOV>; Thu, 7 Mar 2002 17:14:21 -0500
Received: from web13408.mail.yahoo.com ([216.136.175.66]:22033 "HELO
	web13408.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310231AbSCGWOJ>; Thu, 7 Mar 2002 17:14:09 -0500
Message-ID: <20020307221406.21519.qmail@web13408.mail.yahoo.com>
Date: Thu, 7 Mar 2002 14:14:06 -0800 (PST)
From: alal <alal_91801@yahoo.com>
Subject: Re: mkdep.c error under Mandrake8.1-2.4.8
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C8718E4.903@tmsusa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe, 

Thanks for your reply.

Which package I should look for then? 

I already tried to search for kernel packages at the
very beginning. Not sure whether I did that right-- I
search for 'kernel', 'kernel headers', 'kernel source'
under Mandrake package update. 

I was told that an about 13 M kernel was already
installed, including kernel headers under '/boot', 
and something like 'kernel-doc' under /lib. 

I'm using ltmodem-6.00b15.tar.gz
(http://www.heby.de/ltmodem).  It has a required-file
list. I checked it and got all files installed, except
a GNU C library, which doesn't exist in 2.4 version.

When I start ./build_module to build the driver, it
looks for kernel headers under some non-exist
directories like '/usr/src/linux'. 

I made such a directory, linked or even copied the
kernel header file from /boot to it;  I also tried to
put that header file under
/usr/src/linux/kernel-headers/ or rename the header
files or something..  No matter what it just told me
can't find the kernel headers.

I almost gave up, then I saw some suggestion to get
the kernel source from 'www.kernel.org'... After I
installed that, I now have a /usr/src/linux directory
and others. But.. well, then I come here :(

Anyway, now I just try to get that mkdep.c file from
another kernel version and see whether it can replace
my version.

Thanks again,

alal




--- J Sloan <joe@tmsusa.com> wrote:
> alal wrote:
> 
> >Hi there,
> >
> >I'm a newbie on Linux and just try to setup my
> Viking
> >56K PCI modem under
> Mandrake8.1(kernel-2.4.8-26mdk). 
> >
> >I downloaded kernel source
> files(linux-2.4.8.tar.gz)
> >two days ago from www.kernel.org and installed it
> >under '/usr/src' to construct the '/usr/src/linux '
> >directory.
> >
> It's better to just install the mandrake kernel
> source package instead - that will match the
> kernel you are running.
> 
> Joe
> 
> 
> 




__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
