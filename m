Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSHPC3p>; Thu, 15 Aug 2002 22:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSHPC3p>; Thu, 15 Aug 2002 22:29:45 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:53775 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318076AbSHPC3o>; Thu, 15 Aug 2002 22:29:44 -0400
Date: Thu, 15 Aug 2002 23:32:55 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <Pine.LNX.4.44.0208151905500.1271-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0208152331480.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Linus Torvalds wrote:
> On Thu, 15 Aug 2002, Benjamin LaHaise wrote:
> >
> > A 4G/4G split flushes the TLB on every syscall.
>
> This is just not going to happen. It will have to continue being a 3/1G
> split, and we'll just either find a way to move stuff to highmem and
> shrink the "struct page", or we'll just say "screw those 16GB+ machines
> on x86".

I don't like a 4G/4G split at all, either.

But on the other hand, I don't hate it as much as all the
kludges that are being pushed into the kernel to support
these large machines right now ...

As long as it's just these huge machines that suffer, and
not the sane systems ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

