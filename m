Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262301AbTINEhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 00:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbTINEhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 00:37:16 -0400
Received: from codepoet.org ([166.70.99.138]:29093 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262301AbTINEhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 00:37:14 -0400
Date: Sat, 13 Sep 2003 22:37:17 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: People, not GPL  [was: Re: Driver Model]
Message-ID: <20030914043716.GA19223@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030914034218.GA18627@codepoet.org> <Pine.LNX.4.10.10309132029350.16744-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10309132029350.16744-100000@master.linux-ide.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 13, 2003 at 08:36:36PM -0700, Andre Hedrick wrote:
> Wow ... Does "Original Work" have meaning?
> 
> Does an "Original Work" using only the standard kernel API headers to
> interface mean it is a derived work?  You better go find a new lawyer.

You seem to be somewhat confused as to who needs a lawyer.  I'm
not the one asking this question.   I am also not the one trying
to make a closed source binary only product that runs within the
context of the Linux kernel, and then complaining that the GPL
wackos are ruining my business...  It seems to be that doing such
a thing would be a really stupid business model.

As I recall it is the One True(tm) iSCSI stack you are working
on, right?

> "fair usage" of .h files as the API is standard.
> 
> Using any .c or kernel C code is a NO NO.

I invite you to read the COPYING file included in each and every
kernel tarball.  There is exactly ONE exception granted in the
linux kernel copyright:

    This copyright does *not* cover user programs that use kernel
    services by normal system calls - this is merely considered
    normal use of the kernel, and does *not* fall under the
    heading of "derived work".

All the noise in the world about other exceptions is precisely
that, since the license granting use of the Linux kernel does
not contain any additional provisions.

Anything that can be identified as a "user program" that "use[s]
kernel services by normal system calls" is, by virtue of the above
license grant, doing so with permission and is therefore within
its rights.  So you can make all the closed source user space
only One True(tm) iSCSI stacks you want.

Anything that is not a "user program" (and I think everyone can
agree a kernel module is not a "user program") is therefore a
derivitive work.

Anything that is linked into the kernel (and I think everyone can
agree a kernel module is linked into the kernel) and is therefore
interfacing with kernel internals, rather than using "kernel
services by normal system calls" is therefore a derivitive work.

Laugh at people, mock people, rant, rave, wantever you want.
When you are done making noise, please have your laywer explain
how a closed source binary only product that runs within the
context of the Linux kernel is not a derivitive work, per the
very definition given in the kernel COPYING file that grants you
your limited rights for copying, distribution and modification,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
