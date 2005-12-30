Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbVL3Hax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbVL3Hax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVL3Hax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:30:53 -0500
Received: from [202.125.80.34] ([202.125.80.34]:1619 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1751202AbVL3Haw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:30:52 -0500
Content-class: urn:content-classes:message
Subject: RE: Howto set kernel makefile to use particular gcc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 30 Dec 2005 12:55:24 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B2239CF@mail.esn.co.in>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-TNEF-Correlator: 
Thread-Topic: Howto set kernel makefile to use particular gcc
Thread-Index: AcYNEXS80bE/JFqNSCe7rPdsgAAxRwAAJ/6Q
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Chris White" <chriswhite@gentoo.org>
Cc: "Alessandro Suardi" <alessandro.suardi@gmail.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for that.
I will test it

thanks,
Mukund Jampala

> -----Original Message-----
> From: Chris White [mailto:chriswhite@gentoo.org]
> Sent: Friday, December 30, 2005 12:54 PM
> To: Mukund JB.
> Cc: Alessandro Suardi; linux-kernel@vger.kernel.org
> Subject: Re: Howto set kernel makefile to use particular gcc
> 
> 
> On Friday 30 December 2005 16:04, Mukund JB. wrote:
> > Dear Alessandro,
> >
> > Thanks for the reply.
> > What does that the make CC=<path_to_your_gcc_3.3> do?
> > Will it set my gcc default build configuration to gcc 3.3?
> 
> Not Alessandro but,
> 
> CC sets the CC makefile variable.  When the kernel build 
> system goes to 
> compile something, it doesn't call on gcc directly, but 
> rather what the 
> variable CC is set to.  By setting it to your gcc 3.3 
> compiler, it will use 
> that instead.
> 
> > I mean the general procedure is make bzImage; make modules....
> > How do I do these:
> >
> > Will I have to do it like:
> > 	make bzImage cc=<gcc path>
> 
> make CC=<gcc path> bzImage
> 
> note the case sensitivity, which tends to be somewhat of a 
> pain for new *nix 
> users.
> 
> > Best Regards,
> > Mukund Jampala
> 
> Chris White
> 
