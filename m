Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTEMMMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbTEMMMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:12:55 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:8186 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263653AbTEMMMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:12:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: The disappearing sys_call_table export.
Date: Tue, 13 May 2003 07:24:49 -0500
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305122200_MC3-1-3890-B10B@compuserve.com>
In-Reply-To: <200305122200_MC3-1-3890-B10B@compuserve.com>
MIME-Version: 1.0
Message-Id: <03051307244901.19075@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 May 2003 20:57, Chuck Ebbert wrote:
> Alan Cox wrote:
> > 1. Base Linux is not C2 certified
>
>   That could be fixed... (right?)  Filesystems returning data past the
> end of what the user wrote might be a big problem though -- this must
> be guaranteed even in obscure corner cases.

No - C2 evaluation has not been done for almost 3 years. That makes it
impossible to get a C2 evaluation.

> > 2. C2 is obsolete
>
>   Obsolete or not, it is mandatory for some people.  No check box,
> no purchase order (or no certificate of operation.)

Bullshit - NO OS is C2 anymore. The last certification was given to MS for
NT 4 - about 3 years ago. NONE of the current systems are C2. The best you
can get is "C2 like capability", and that is not a verified operation. And
"C2 like capability" Linux does just as well as M$. Are the log files as
pretty as would be desired? No. But they are acceptable for all US usage
where a UNIX system is acceptable. (And don't even try to claim M$ produces
a secured box... I haven't even been able to find the "trusted facility 
manual" for the released systems... which is a requirement for operation.

> > 3. NSA SELinux can do the needed stuff from scanning the code
>
>   But will it get merged?

I don't know, but I hope so. (2.7 maybe?)

> > 4. Even then data erasure is not guaranteed because of the drive logic
>
>   People who really care require the drive be reduced to pieces small
> enough to fit through a sieve with ~2mm holes in it before it leaves
> their sight.  For the rest, overwrite of the swap data is a useful if
> not 100% reliable step to take.  Legitimate users with servers locked
> up in secure areas don't really worry about someone unplugging the box
> and walking away with it either.

These are also the same people that will not (or should not) accept laptops in
their environement.
