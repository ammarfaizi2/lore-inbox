Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRLRPOF>; Tue, 18 Dec 2001 10:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRLRPNz>; Tue, 18 Dec 2001 10:13:55 -0500
Received: from [213.236.192.200] ([213.236.192.200]:33202 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S279768AbRLRPNq>; Tue, 18 Dec 2001 10:13:46 -0500
Message-ID: <026701c187d5$ec2472c0$67c0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E16GLmv-0007d4-00@the-village.bc.nu>
Subject: Re: The direction linux is taking
Date: Tue, 18 Dec 2001 16:09:00 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 1. Are we satisfied with the source code control system ?
> >
> > Yes.  Alan (2.2) and Marcelo (2.4) and Linus (2.5) are doing
> > a good job with source control.
>
> Not really. We do a passable job. Stuff gets dropped, lost,
> deferred and forgotten, applied when it conflicts with other work
> - much of this stuff that software wouldnt actually improve on over a
> person

What about having the Linux source code in a CVS tree where active/trusted
driver-/module-maintainers are granted write access, and everyone else read
access.
After the patches are applied, people will test them out, and bugfixes will
be applied when bugs are detected.
Then, when the kernel-maintainer feels this or that sourcecode is ready for a
.pre kernel, he puts it in the main kernel tree.
(This would indeed pose a security risk, but who in their right mind would run
 a CVS snapshot on anything important, that's right _noone_ in their _right
mind_)

Of course this would require much maintenance, and possibly more than
one kernel-maintainer. This because of how much easier it would become
for driver-/module-maintainers to apply patches they believe would make
things better. Cleanups would also be necessary from time to time..
(cleanups = making the CVS identical to the main kernel tree again)

Just my 2 cents..

-=Dead2=-




