Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbSCOIhK>; Fri, 15 Mar 2002 03:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285229AbSCOIhA>; Fri, 15 Mar 2002 03:37:00 -0500
Received: from adsl-64-169-88-198.dsl.snfc21.pacbell.net ([64.169.88.198]:35207
	"EHLO fokker") by vger.kernel.org with ESMTP id <S284933AbSCOIgw>;
	Fri, 15 Mar 2002 03:36:52 -0500
Message-ID: <3C91B2A1.48C74B82@ianduggan.net>
Date: Fri, 15 Mar 2002 00:36:49 -0800
From: Ian Duggan <ian@ianduggan.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18+mki+w4l i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <1016157250.4599.62.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Pretty clear it is win4line.  Is it SMP-safe?
> 
> Is there another kernel module you load for win4lin?  Binary?  It needs
> to be made preempt (and SMP) -safe.

It is SMP safe. I've used it for ages on SMP kernels. The frutstrating
thing is that it worked for weeks without a hitch using
2.4.17+preempt+mki+win4lin. It is only recently that I began to
experience very intermittent problems on that kernel.

What does it mean to make something "preempt" safe? Is it something
beyond "SMP safe"?

I misspoke slightly before. The mki-adapter patch actually provides a
GPL'd module. The README from it says:

"This kernel module attempts to isolate all of the functions and
structures that NeTraverse utilizes in it's binary kernel modules."

The win4lin patch (also GPL) provides hooks for the mki-adapter module
to call.

I'm not asking for help fixing it, because of the binary module issue.
I'm just looking for ways to narrow down where the problem might be,
given that the machine completely locks up.

-- Ian

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ian Duggan                    ian@ianduggan.net
                              http://www.ianduggan.net
