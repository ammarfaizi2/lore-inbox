Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285719AbRLTAot>; Wed, 19 Dec 2001 19:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbRLTAoa>; Wed, 19 Dec 2001 19:44:30 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:5901 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S285719AbRLTAo0>; Wed, 19 Dec 2001 19:44:26 -0500
Date: Wed, 19 Dec 2001 16:47:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <20011219192136.F2034@redhat.com>
Message-ID: <Pine.LNX.4.40.0112191631450.1529-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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




- Davide



