Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTLEGfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 01:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTLEGfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 01:35:01 -0500
Received: from mail.webmaster.com ([216.152.64.131]:52382 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263823AbTLEGe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 01:34:57 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <Valdis.Kletnieks@vt.edu>, "Peter Chubb" <peter@chubb.wattle.id.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause? 
Date: Thu, 4 Dec 2003 22:34:37 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200312050513.hB55D1ps030713@turing-police.cc.vt.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, 05 Dec 2003 15:23:10 +1100, Peter Chubb said:
>
> > As far as I know, interfacing to a published API doesn't infringe
> > copyright.
>
> Well, if the only thing in the .h files was #defines and
> structure definitions,
> it would probably be a slam dunk to decide that, yes.
>
> Here's the part where people's eyes glaze over:
>
> % cd /usr/src/linux-2.6.0-test10-mm1
> % find include -name '*.h' | xargs egrep 'static.*inline' | wc -l
>    6288
>
> That's 6,288 chances for you to #include GPL code and end up
> with executable derived from it in *your* .o file, not the kernel's.

	I'm sorry, but that just doesn't matter. The GPL gives you the unrestricted
right to *use* the original work. This implicitly includes the right to
peform any step necessary to use the work. (This is why you can 'make a
copy' of a book on your retina if you have the right to read it.) Please
tell me how you use a kernel header file, other than by including it in a
code file, compiling that code file, and executing the result.

> More to the point, look at include/linux/rwsem.h, and ask yourself
> how to call down_read(), down_write(), up_read(), and up_write()
> without getting little snippets of GPL all over your .o.

	Exactly, it's impossible. So doing so is a necessary step to using the
header file.

> And even if your module doesn't get screwed by that, there's a
> few other equally dangerous inlines waiting to bite you on the posterior.

	No problem. If you can't avoid them, then you're allowed to do them.

> I seem to recall one of the little buggers was particularly
> nasty, because it
> simply Would Not Work if not inlined, so compiling with
> -fno-inline wasn't an
> option.  Unfortunately, I can't remember which it was - it was
> mentioned on
> here a while ago when somebody's kernel failed to boot because a
> gcc 3.mumble
> had broken inlining.....

	So you're argument is that it's impossible to use the header file without
creating a derived work, hence permission to use the header file is
permission to create the derived work. This supports my argument that you
can create a derived work without agreeing to the GPL. Thanks.

	DS


