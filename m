Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293190AbSCEGIJ>; Tue, 5 Mar 2002 01:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293614AbSCEGH7>; Tue, 5 Mar 2002 01:07:59 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:20751 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S293190AbSCEGHq>; Tue, 5 Mar 2002 01:07:46 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Robert Love <rml@tech9.net>, Hubertus Franke <frankeh@watson.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III. 
In-Reply-To: Your message of "Mon, 04 Mar 2002 19:55:19 -0800."
             <Pine.LNX.4.44.0203041953480.1561-100000@blue1.dev.mcafeelabs.com> 
Date: Tue, 05 Mar 2002 17:11:04 +1100
Message-Id: <E16i8AD-0007Sb-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0203041953480.1561-100000@blue1.dev.mcafeelabs.com> y
ou write:
> On Tue, 5 Mar 2002, Rusty Russell wrote:
> 
> > In message <1015293007.882.87.camel@phantasy> you write:
> > > On Mon, 2002-03-04 at 17:15, Davide Libenzi wrote:
> > >
> > > > That's great. What if the process holding the mutex dies while there're
> > > > sleeping tasks waiting for it ?

I don't see that.  Your data, your program, your funeral, yes?

Want to autoclean the lock?  There are many ways to do this in
userspace.  For most cases, the problem is "and then what"?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
