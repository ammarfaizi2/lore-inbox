Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTAAAlF>; Tue, 31 Dec 2002 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTAAAlF>; Tue, 31 Dec 2002 19:41:05 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:51673 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S264910AbTAAAlE>;
	Tue, 31 Dec 2002 19:41:04 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
References: <Pine.LNX.4.10.10212310412290.421-100000@master.linux-ide.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 31 Dec 2002 16:11:58 +0100
In-Reply-To: <Pine.LNX.4.10.10212310412290.421-100000@master.linux-ide.org>
Message-ID: <m3k7hq2pfl.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> writes:

> Are you a customer of Nvidia?
> If you are not, you have no legal ground to invoke GPL PERIOD!

Which country has such weird copyright laws?

> If you are a customer, check to see that they have a GPL/GNU wrapper which
> is open source and attachs a clean LGPL library object, iirc.

I don't think we have LGPL code in the kernel, but of course I can be
wrong here.
Anyway, NVidia has binary driver being a kernel component and XFree86
driver. While XFree86 driver may or may not be subject to X11 license,
the kernel part (an object file which is then linked to a kernel module
glue code) does not seem to be derived from kernel code.

> Since, there is still a legal and valid LGPL regardless of what FSF has to
> say, there are revisions of GPL which permit various usages.

Still, LGPL has nothing to do with it. The kernel code is licensed
under version 2 of GPL (or maybe later version, but there isn't any).

Having or not having money has nothing to do with it either.

> Now until the kernel forcable rejects loading binary closed source
> modules, it defaults to quietly approved of the concept regardless what
> you think, feel, or care.

Kernel behaviour is not related to legal issues.

> If the kernel forces vendors to choose between closed source support or
> loose the competive edge in their market space, enjoy hunting for the old
> dusty video cards from the past.  You just limited the scope of hardware
> which will run on Linux with any usability.

Forget it. The kernel itselt can't force anyone to do anything. That is
the license that matters.
BTW: Of course, vendors are free to produce drivers for their hardware.
Have you seen such a closed-source driver which was working correctly?
I haven't.

> So you submitted a patch, whippty flip ... neither you or I control the
> license of the kernel.  If Linus does not like the content of a patch or a
> file generated, well it is toast.  Also where does it state a patch is
> defined as "GPL patch"?

IANAL, but I'd assume a patch doesn't change the license for a product
(a file etc), unless stated otherwise.

> Think a little harder first, cause I and many others will be on the side
> of slapping down your arguements about preventing binary modules from
> being loaded.  Key point! "LOADED" not "LINKED".

A module has to be linked when it's loaded. But it, of course, doesn't
matter - the GPL doesn't prevent you from linking GPL code to anything
you want, unless you want to distribute such a beast.
-- 
Krzysztof Halasa
Network Administrator
