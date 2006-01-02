Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWABGFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWABGFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 01:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWABGFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 01:05:52 -0500
Received: from [202.125.80.34] ([202.125.80.34]:1400 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932327AbWABGFv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 01:05:51 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: Howto set kernel makefile to use particular gcc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 2 Jan 2006 11:29:55 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B223AF3@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Howto set kernel makefile to use particular gcc
Thread-Index: AcYNGhnnJYnaHzirR4S63uxQmNC8mACRwGow
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jasper,

But I was doing it all that I was doing with 2.4 i.e. the follwoing steps to build the kernel.
I also found these steps are followed in the 2.6.x kernel build howto's too.

Do you mean, to rebuild the 2.6.x kernel,

	make CC=<path of gcc> would be enough?

I am just thinking whether I am doing something redundent.

Regards,
Mukund Jampala


> -----Original Message-----
> From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> Sent: Friday, December 30, 2005 1:55 PM
> To: Mukund JB.
> Cc: Alessandro Suardi; linux-kernel@vger.kernel.org
> Subject: Re: Howto set kernel makefile to use particular gcc
> 
> 
> On 12/30/05, Mukund JB. <mukundjb@esntechnologies.co.in> wrote:
> >
> > Dear Alessandro,
> >
> > Thanks for the reply.
> > What does that the make CC=<path_to_your_gcc_3.3> do?
> > Will it set my gcc default build configuration to gcc 3.3?
> >
> > I mean the general procedure is make bzImage; make modules....
> 
> That was the common way with 2.4.x kernels. Sure, you can still do
> that, but with 2.6.x the recommended thing is to just do "make" (or in
> your case "make CC=</path/to/gcc-3.3>") which will both build the
> kernel and the modules.
> 
> 
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> 
