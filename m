Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTEMXpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTEMXpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:45:53 -0400
Received: from corky.net ([212.150.53.130]:24028 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262406AbTEMXpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:45:49 -0400
Date: Wed, 14 May 2003 02:58:29 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Ahmed Masud <masud@googgun.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <3EC176DA.3060702@googgun.com>
Message-ID: <Pine.LNX.4.44.0305140234110.32259-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 May 2003, Ahmed Masud wrote:

> This definitely sounds very interesting.  I can start looking at this
> problem seriously and see if i can put something together for 2.5.x
> since crypto subsystem routines are largely in place.

Yes, it sounds like an interesting project.  Check out openbsd's paper
about this: http://www.openbsd.org/papers/swapencrypt.ps
Let me know when you get it rolling.  I'll try to help where I can.
I just hope it has a chance to be included.

> > Another fun project is encrypted hibernation (suspend-to-disk).  Once the
> > kernel contains a stable hibernation option, I'm certainly going to
> > encrypt it.
> >
>
> Yes that too could be a fun thing to do.

Actually, I forgot that swsusp is now included.  I haven't tried it in a
while.  Anyone knows if its stable enough to start playing with encrypting
it ?

	Yoav Weiss

