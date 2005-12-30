Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbVL3HJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbVL3HJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVL3HJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:09:49 -0500
Received: from [202.125.80.34] ([202.125.80.34]:34895 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1751198AbVL3HJt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:09:49 -0500
Content-class: urn:content-classes:message
Subject: RE: Howto set kernel makefile to use particular gcc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 30 Dec 2005 12:34:21 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B2239C2@mail.esn.co.in>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: Howto set kernel makefile to use particular gcc
Thread-Index: AcYNDgrl5YVuSe2iQ2SPCh6RBwl9bQAAFzVw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Alessandro,

Thanks for the reply.
What does that the make CC=<path_to_your_gcc_3.3> do? 
Will it set my gcc default build configuration to gcc 3.3?

I mean the general procedure is make bzImage; make modules....
How do I do these:

Will I have to do it like:
	make bzImage cc=<gcc path>

Best Regards,
Mukund Jampala


> -----Original Message-----
> From: Alessandro Suardi [mailto:alessandro.suardi@gmail.com]
> Sent: Friday, December 30, 2005 12:29 PM
> To: Mukund JB.
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Howto set kernel makefile to use particular gcc
> 
> 
> On 12/30/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
> >
> > Dear Kernel mailers,
> >
> > I have specific requirement of building kernel 2.6.11.12 
> with gcc- 3.3 over the FC4 dist.
> > I have downloaded the gcc-3.3.
> > As FC4 comes with a default gcc-4.0, how do I set the 
> kernel Makefile to use the gcc-3.3 instead of gcc-4.0.
> >
> > How do I achieve it? I know it is a very small issue and 
> searched google and I am unable to find it.
> 
> Leave the kernel Makefile alone, and say
> 
> cd /usr/src/linux
> make CC=<path_to_your_gcc_3.3>
> 
> --alessandro
> 
>  "Somehow all you ever need is, never really quite enough, you know"
> 
>    (Bruce Springsteen - "Reno")
> 
