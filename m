Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbUDEVoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDEVnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:43:16 -0400
Received: from web40506.mail.yahoo.com ([66.218.78.123]:39568 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263280AbUDEVkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:40:08 -0400
Message-ID: <20040405214007.68717.qmail@web40506.mail.yahoo.com>
Date: Mon, 5 Apr 2004 14:40:07 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Chris Wright <chrisw@osdl.org>
Cc: John Stoffel <stoffel@lucent.com>, Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <20040405140810.C22989@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Chris Wright <chrisw@osdl.org> wrote:
> * Sergiy Lozovsky (serge_lozovsky@yahoo.com) wrote:
> > No :-) What you suggest is kernel should receive
> > system call from user space. Instead of handling
> it -
> > kernel should forward it back to userspace, than
> it
> > should be forwarded back to the kernel. Looks not
> very
> > nice to me. Why not to handle security policy
> inside
> > the kernel as it is done for the file permissions
> and
> > root priveleges?
> 
> All this can be done w/out having a LISP
> interpretter coming along for the
> ride, that's the point of the other posters.  With
> LSM you have a
> framework for implementing your own security model
> and enforcing your own
> policies.

LSM use another way of doing similar things :-) I'm
not sure that it is nice to forward system calls back
to userspace where they came from in the first place
:-) VXE use high level language to create security
models.

And what are the problems with technology used by VXE?
File permissions are checked in the kernel and
everybody are happy with that. VXE just extends
security features already available in the kernel.

There is a historic part to all that, too - VXE was
created (1999) before SELinux was available.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
