Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbTLKSqh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 13:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbTLKSqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 13:46:37 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:4559 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S265232AbTLKSqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 13:46:35 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Jesse Pollard <jesse@cats-chateau.net>
Date: Thu, 11 Dec 2003 10:47:28 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Message-ID: <3FD84B40.2288.66EB3B3C@localhost>
References: <3FD72F7E.4493.6296CE66@localhost>
In-reply-to: <03121109291901.01687@tabby>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <jesse@cats-chateau.net> wrote:

> > You miss my point. I was talking about a single kernel version. For a
> > single kernel version, the ABI is both *published* and *stable*. Sure it
> > may not be what you consider a *clean* or *good* ABI, but it *IS* an
> > ABI. Note that:
> >
> > 1. It is a published ABI because for that one kernel release, all the
> > source code is available that documents the ABI (albiet badly IYO).
> >
> > 2. It is stable because that kernel version will never change on your
> > machine.
> 
> Huh? I frequently update the kernel, and the kernel minor version... as
> well as switch from uniprocessor to SMP. The major version may not change,
> but that minor one certanly does. And adding SMP changes the ABI for that
> version. And patches CAN and DO change the ABI, even within the major
> version.

So what? You don't change it on *MY* machine, now do you? *MY* version 
remains stable regardless of what *YOU* do unless I update my source 
code.

> How do you handle the differences in a single version for
> something like SMP? It is still the same version, but a binary
> driver for SMP will most likely NOT work on uniprocessor, and even
> more likey not work if compiled for a uniprocessor under SMP. 

No, it is not the same version. One is the UNI version and one is the SMP 
version. By version of kernel I mean the version of the binary that I am 
building the loadable module to work with. You can just consider the 
UNI/SMP support to be an extension of the version and treat them as 
different versions (after all, you will need two separate modules to 
handle this anyway).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

