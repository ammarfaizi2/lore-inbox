Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVC0VtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVC0VtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVC0VtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:49:16 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52428 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261597AbVC0VtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:49:12 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <greg@kroah.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050327181056.GA14502@kroah.com>
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk>
	 <20050326182828.GA8540@kroah.com> <1111869274.32641.0.camel@mindpipe>
	 <20050327004801.GA610@kroah.com> <1111885480.1312.9.camel@mindpipe>
	 <20050327032059.GA31389@kroah.com> <1111894220.1312.29.camel@mindpipe>
	 <20050327181056.GA14502@kroah.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 27 Mar 2005 13:37:11 -0500
Message-Id: <1111948631.27594.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 10:10 -0800, Greg KH wrote:

> How about the fact that when you load a kernel module, it is linked into
> the main kernel image?  The GPL explicitly states what needs to be done
> for code linked in.
> 
I've always wondered about dynamically loaded modules (and libraries for
that matter).  The standard IANAL, but I've talked to many to try to
understand what is really legal, and I usually come up with the
conclusion, it's just an interpretation of the law by the judge.

If the user is loading the module (or library) and the distributer
doesn't, then is the the user breaking the license and not the
distributer?

> Also, realize that you have to use GPL licensed header files to build
> your kernel module...
> 

Wasn't this long ago proven in court that the license of headers can't
control the code that calls them.  IIRC, it was with X Motif and making
free libraries for that. So, actually it was for a free solution for a
non free one (the other way around).  I believe the case sided on the
free use. But then again the free code may have had to write their own
headers and only the API was free. So if you want to compile against the
kernel, you may need to work on rewriting the headers from scratch. Ah,
but what do I know?

My code usually falls under something like LGPL. Link with what you
want, but keep any changes to my code open.  I know that this is not the
stance of the kernel and I respect that. But I'm still waiting for the
day in court that talks about dynamic modules and libraries.

-- Steve




