Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWFPDgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWFPDgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWFPDgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:36:12 -0400
Received: from brain.cel.usyd.edu.au ([129.78.24.68]:45018 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S1750997AbWFPDgK (ORCPT <rfc822;linux-Kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:36:10 -0400
Message-Id: <5.1.1.5.2.20060616132151.04502988@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Fri, 16 Jun 2006 13:36:02 +1000
To: "Tyler Littlefield" <compgeek13@gmail.com>
From: sena seneviratne <auntvini@cel.usyd.edu.au>
Subject: Re: a newbie with the kernel--a few questions
Cc: linux-Kernel@vger.kernel.org
In-Reply-To: <001601c690f2$b18756c0$6401a8c0@gramdmasfury>
References: <5.1.1.5.2.20060616111106.04488d40@brain.sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tyler,

This is quite possible.

The ps command reads ALL or most of the info it needs from the /proc
directory. The proc filesystem is a virtual filesystem implemented by the
kernel.

If you change ps software then you will be able to implement these security 
restrictions.

(1) check the login
(2) if only root , then read and show from /proc files.

You can get the source code of ps from

http://ftp.debian.org/debian/dists/potato/main/source/admin/psmisc_19.orig.tar.gz 



Thanks
Sena Seneviratne
Computer Engineering Lab
School of Electrical and Information Engineering
Sydney University
Australia





At 09:12 PM 6/15/2006 -0600, you wrote:
>OK, I am pretty good with c. My goal here is... Well, when a user types who,
>I don't want it to work, unless its root. (easy to change) but I want some
>security like that in the kernel. Also, I want to limit it to when the user
>types ps, they can't get everyone's processes, but jsut there own, unless of
>course, they are root.
>Thanks,
>~~TheCreator~~
>website:
>http://tysplace.shaned.net
>msn:
>compgeek134@hotmail.com
>aim:
>st8amnd2005
>skype:
>st8amnd127
>moo coder/wizard and administrator
>
>----- Original Message -----
>From: "sena seneviratne" <auntvini@cel.usyd.edu.au>
>To: "Tyler Littlefield" <compgeek13@gmail.com>
>Cc: <linux-Kernel@vger.kernel.org>
>Sent: Thursday, June 15, 2006 8:01 PM
>Subject: Re: a newbie with the kernel--a few questions
>
>
> > Hi,
> >
> > I have done some kernel programming with the kernel 2.4.19 and implemented
> > some features which are required by some of our research projects.
> >
> > (1) The first thing is you have to be good in C programming.
> >
> > (2) Then you should know what you would like to do. Whether it would be an
> > addition of new feature? or an improvement?
> >
> > (3)At this place kernel code is available for cross-referencing and
> > learning etc
> >   http://lxr.linux.no/source/
> >
> > (4) You can download kernel from
>http://www.kernel.org/pub/linux/kernel/v2.6/
> >
> > What is your objective?
> >
> > Thanks
> > Sena Seneviratne
> > Computer Engineering Lab
> > School of Electrical and Information Engineering
> > Sydney University
> > Australia
> >
> >
> >
> >
> > At 05:03 PM 6/15/2006 -0600, you wrote:
> > >Hello list,
> > >I have a couple questions.
> > >First, I want to get into kernel programming.
> > >It looks kinda, imposing with the directories and everything. How do you
> > >know what is what? If you want to write something, how do you know where
>to
> > >put it in so that it conflict with other things? Also, how do you know
>what
> > >functions are where? I guess I am just looking for something on the
>design
> > >of the kernel, probably its structure when looking at the source code.
> > >thanks,
> > >~~TheCreator~~
> > >website:
> > >http://tysplace.shaned.net
> > >msn:
> > >compgeek134@hotmail.com
> > >aim:
> > >st8amnd2005
> > >skype:
> > >st8amnd127
> > >moo coder/wizard and administrator
> > >
> > >-
> > >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>in
> > >the body of a message to majordomo@vger.kernel.org
> > >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >Please read the FAQ at  http://www.tux.org/lkml/
> >

