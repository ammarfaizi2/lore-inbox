Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282276AbRLVUtt>; Sat, 22 Dec 2001 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282378AbRLVUtk>; Sat, 22 Dec 2001 15:49:40 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:48390 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282276AbRLVUt1>; Sat, 22 Dec 2001 15:49:27 -0500
Date: Sat, 22 Dec 2001 12:51:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Keith Owens <kaos@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing
In-Reply-To: <8727.1009020535@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.40.0112221250040.1617-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001, Keith Owens wrote:

[...]

<>
On Wed, 19 Dec 2001, Benjamin LaHaise wrote:

> What I'm saying is that for more people to play with it, it needs to be
> more widely available.  The set of developers that read linux-kernel and
> linux-aio aren't giving much feedback.  I do not expect the code to go
> into 2.5 at this point in time.  All I need is a set of syscall numbers
> that aren't going to change should this implementation stand up to the
> test of time.

It would be nice to have a cooperation between glibc and the kernel to
have syscalls mapped by name, not by number.
With name->number resolved by crtbegin.o reading a public kernel table
or accessing a fixed-ID kernel map function and filling a map.
So if internally ( at the application ) sys_getpid has index 0, the
sysmap[0] will be filled with the id retrieved inside the kernel by
looking up "sys_getpid".
Eat too spicy today ?
<>

So i did not eat too spicy that day :)




- Davide


