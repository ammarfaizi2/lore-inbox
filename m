Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130548AbQKNTFF>; Tue, 14 Nov 2000 14:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130689AbQKNTEz>; Tue, 14 Nov 2000 14:04:55 -0500
Received: from nat.dmz.icopyright.com ([209.191.160.234]:48409 "EHLO
	enki.corp.icopyright.com") by vger.kernel.org with ESMTP
	id <S130548AbQKNTEk>; Tue, 14 Nov 2000 14:04:40 -0500
Date: Tue, 14 Nov 2000 10:33:54 -0800 (PST)
From: <lamont@icopyright.com>
To: Josue Emmanuel Amaro <Josue.Amaro@oracle.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
In-Reply-To: <3A106380.CE41BBAE@oracle.com>
Message-ID: <Pine.LNX.4.21.0011141019490.20274-100000@enki.corp.icopyright.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


if you look at the kstat structure under solaris, there's a lot of info
there that'd be good to be able to pull out of the linux kernel.  that
would slow down the kernel a little, lead to some 'bloat' that linus
abhors and such, but its good to have that information for monitoring and
debugging problems.  it'd also be nice to have hooks built in to monitor
errors in the disk subsystem and ideally warn of impending failures as
much as possible -- that might be better done in userspace.  and pretty
much you want all error messages from different subsystems to be monitored
and appropriate action taken.  ideally all error messages from the kernel
and device drivers should be standardized and HA software can then monitor
them and take appropriate actions when it sees one that indicates
failure.  sun is currently in the process of documenting all the kernel
error messages from what i understand.  those are the kinds of things that
give IT managers and sysadmins warm fuzzy feelings about solaris.

On Mon, 13 Nov 2000, Josue Emmanuel Amaro wrote:
> This subject came up in the Generalized Kernel Hooks Interface thread, since it
> is an area of interest to me I wanted to continue that conversation.
> 
> While I do not think it would be productive to enter a discussion whether there
> is a need to fork the kernel to add features that would be beneficial to
> mission/business critical applications, I am curious as to what are the features
> that people consider important to have.  By mission critical I mean systems that
> if not functional bring a business to a halt, while by business critical I mean
> systems that affect a division of a business.
> 
> Another problem is how people define Enterprise Systems.  Many base it on the
> definitions that go back to S390 systems, others in the context of the 24/7
> nature of the internet.  That would also be a healthy discussion to have.
> 
> At Oracle we are primarily interested on I/O subsystem features and memory
> management.  (For anyone that knows anything about Oracle this should not come
> as a surprise, although I am pretty sure that any database vendor/developer
> would be interested on those features as well.)
> 
> Regards,
> 
> --
> =======================================================================
>   Josue Emmanuel Amaro                         Josue.Amaro@oracle.com
>   Linux Products Manager
>   Intel and Linux Technologies Group
> =======================================================================
> 
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
