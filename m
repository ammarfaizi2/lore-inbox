Return-Path: <linux-kernel-owner+w=401wt.eu-S1752672AbWLSGf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbWLSGf6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbWLSGf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:35:58 -0500
Received: from mail.enter.net ([216.193.128.40]:21909 "EHLO mmail.enter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbWLSGf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:35:56 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: davids@webmaster.com
Subject: Re: GPL only modules
Date: Tue, 19 Dec 2006 01:35:53 -0500
User-Agent: KMail/1.9.5
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKKECHAHAC.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKECHAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612190135.53832.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 12:16, David Schwartz wrote:
> Combined responses to save bandwidth and reduce the number of times people
> have to press "d".
>
> > Agreed. You missed the point.
>
> I don't understand how you could lead with "agreed" and then proceed to
> completely ignore the entire point I just made.

I *initially* thought you had missed the point. After your later post 
clarifying things I saw that my statement had been in error and that I did 
agree with you completely.

> > Since the Linux Kernel header files
> > contain a
> > chunk of the source code for the kernel in the form of the macros
> > for locking
> > et. al. then using the headers - including that code in your
> > module - makes
> > it a derivative work.
>
> No, it does not. The header files are purely function and not expressive in
> this case. Copyright only protects one choice among many equally-practical
> choices for expressing the same idea or performing the same function.

In this case, well. We aren't talking Copyright, but the license under which 
the software is distributed. According to the USPTO placing a statement such 
as (c) 2006 Pornrat Watanabe on a work you have created automatially places 
it under a copyright. The kernel source code, copyrighted as it is, is then 
distributed under the terms of the GNU GPL. 

Using the code from the header files may not make the module a derivative, but 
it is including parts of a copyrighted work. By *NOT* complying with the 
license under which said copyrighted work is distributed, you are giving up 
your rights under the license.

This doesn't negate any problems with people making Blob drivers, because, as 
you pointed out, under the same laws they aren't a derivative work, which 
means that that clause of the license doesn't apply. Now if the GPL contained 
a clause specifically defining what it considered a derivative work things 
would be different.

> > Actually, thinking about it, the way a Linux driver module works actually
> > seems to make *ANY* driver a derivative work, because they are
> > loaded into
> > the kernels memory space and cannot function without having that done.
>
> If every practical way of expressing an idea contains something, then that
> something is *not* protectable when used to express an idea of that kind.

Not what I was saying. There are any number of ways to make a driver 
function - the FUSE system has shown that clearly. But by making that driver 
one that is loaded directly into the kernels memory space...

It's that act that *I* *FEEL* makes it a derivative work.

> > *IF* the "Usermode Driver" interface that is being worked on ever proves
> > useful then, and only then, could you consider it *NOT* a
> > derivative work.
> > Because then the only thing it is using *IS* an interface, not complete
> > chunks of the source as generated when the pre-processor finishes running
> > through the file.
>
> No, you have it completely backwards.

No, you missed my point. I was saying that the Usermode Driver interface would 
make the current style of kernel modules fully derivative works. This being 
because they are using an open system interface and *NOT* including code 
distributed with the kernel.

> If a usermode driver interface was equally practical to develop a
> particular type of driver, then using the kernel headers would make the
> driver a derivative work. Because, in that case, the choice to use the
> kernel headers would be a creative choice -- one chosen method among many
> equally practical one.

And this is what I was saying. Perhaps I didn't state it in clear and concise 
english.

> Copyright only protects creative choices, not purely functional ones.
>
> "A Linux 2.6 driver for the ATI X800 graphics chipset" is an idea. If the
> only reasonably practical way to express that idea is with the Linux kernel
> header files, then using the Linux kernel header files is scenes a fair,
> not protected content.

Okay. I understood this back at the start of your reply.

<snip>
> DS

Okay, after a lot of thought and me realizing some mistakes I had made in 
interpreting the law and legal precedents I see we are on the same page.

DRH
