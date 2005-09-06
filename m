Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVIFWUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVIFWUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVIFWUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:20:32 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:40907 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751039AbVIFWUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:20:31 -0400
Date: Wed, 7 Sep 2005 00:20:11 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: "Budde, Marco" <budde@telos.de>, linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++
In-Reply-To: <9a87484905090614204ba36b83@mail.gmail.com>
Message-Id: <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005, Jesper Juhl wrote:

> On 9/6/05, Budde, Marco <budde@telos.de> wrote:
> > Hi,
> > 
> > for one of our customers I have to port a Windows driver to
> > Linux. Large parts of the driver's backend code consists of
> > C++.
> > 
> > How can I compile this code with kbuild? The C++ support
> > (I have tested with 2.6.11) of kbuild seems to be incomplete /
> > not working.
> > 
> 
> That would be because the kernel is written in *C* (and some asm), *not* C++.
> There /is/ no C++ support.

Which is too bad. You can do stuff much more elegant, effectively and
safer in C++ than in C. Yes, you can do inheritance in C, but it leaves
it up to the user to make sure the type-casts are done OK every time. You
can with macros do some dynamic typing, but not nearly as effectively as
with templates, and those macros always comes very, very ugly. (Some say
templates are ugly, but they first become ugly when they are used
way beyond what you can do with macros.)

I think it can only be a plus to Linux to add C++ support for at least
out-of-mainline drivers. Adding drivers written in C++ into the mainline
is another thing.

Esben

