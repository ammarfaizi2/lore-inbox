Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUBTJFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 04:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUBTJFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 04:05:54 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:21775 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S267745AbUBTJFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 04:05:46 -0500
Date: Fri, 20 Feb 2004 17:06:15 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Raj <obelix123@toughguy.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Gcc problems on linux-2.6.3
In-Reply-To: <Pine.LNX.4.56.0402201428310.1554@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0402201705420.1046@boston.corp.fedex.com>
References: <Pine.LNX.4.56.0402201411240.1554@localhost.localdomain>
 <Pine.LNX.4.56.0402201428310.1554@localhost.localdomain>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/20/2004
 05:05:41 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/20/2004
 05:05:44 PM,
	Serialize complete at 02/20/2004 05:05:44 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What does "df /tmp" shows?


Thanks,
Jeff
[ jchua@fedex.com ]

On Fri, 20 Feb 2004, Raj wrote:

> Included the subject line now. i apologise.
>
> /Raj
>
> Life is the art of drawing sufficient conclusions from insufficient
> premises.
>
>
> On Fri, 20 Feb 2004, Raj wrote:
>
> > Hi,
> >
> > I am facing a weird problem with gcc 3.2.2 on RedHat 9.0 machine running
> > vanilla 2.6.3.Glibc 2.3.2.
> >
> > gcc fails to compile c programs. More specifically it fails during the
> > assembler phase. I boot back 2.6.2 and things work fine. Below are the
> > error messages.
> >
> > ----start-----
> > /tmp/ccfRiElp.o: File truncated
> > /tmp/ccNO4FCk.s: Assembler messages:
> > /tmp/ccNO4FCk.s:23: FATAL: Can't write /tmp/ccfRiElp.o: File truncated
> > ---end------
> > The source is a simple program which just has a printf.
> >
> > I am attaching the strace output when ran on 2.6.3. If you need
> > strace output of 2.6.2. pls let me know.
> >
> > /Raj
> >
> > Life is the art of drawing sufficient conclusions from insufficient
> > premises.
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
