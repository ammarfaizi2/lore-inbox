Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265240AbSJRUo1>; Fri, 18 Oct 2002 16:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265286AbSJRUo1>; Fri, 18 Oct 2002 16:44:27 -0400
Received: from web21108.mail.yahoo.com ([216.136.227.110]:17321 "HELO
	web21108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265240AbSJRUo0>; Fri, 18 Oct 2002 16:44:26 -0400
Message-ID: <20021018205026.56875.qmail@web21108.mail.yahoo.com>
Date: Fri, 18 Oct 2002 21:50:26 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: Re: RPM installation problem.
To: tompr_2002@yahoo.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Tom Pr <tompr_2002@yahoo.com> wrote:
> Hi Sam,
> 
> Sorry for confusion. It is SRPM. Any idea why I am
> getting this problem. I wanted to install kernel
> source RPM and compile the kernel.
> 
> Thanks.
> 
> --- Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Fri, Oct 18, 2002 at 10:52:47AM -0700, Tom Pr
> > wrote:
> > > Hi All,
> > > 
> > > If I try to install an RPM on my machine, it works
> > > fine. It displays  ####.............  100%. I am
> > > sure it is installing perfectly.Once installation
> > is
> > > completed if I query for the RPM, it says the RPM
> > > never installed. what is it behaving that way? Do
> > I
> > > need to do any thing else?
> > > 
> > > Any inputs will be appreciated.
> > 1) This is not a question for lkml - try the most
> > local LUG ml instead.
> > 2) To my knowledge Source RPM's does not show up in
> > the database, and therefore not in rpm -q.
> >  Maybe it's a SRPM?
> > 
> > 	Sam


Assuming you are using RedHat or similar, you want to install a kernel-source
RPM not a kernel SRPM.  The kernel SRPM is for rebuilding a packaged kernel
RPM, while if you want to play with the distributions kernel source you want
the kernel-source RPM.

Alternativly, you could download kernel source from kernel.org or a mirror. 
This is different to the kernel that came with your distribution.  The kernels
that come with distributions have been modified with various patches for
feature enhancements and/or bugfixes.

It is the kernels available from kernel.org that are discussed on linux-kernel.
 Distribution kernels should be disscussed on distribution mail-lists.


=====
Steve

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
