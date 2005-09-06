Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVIFWW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVIFWW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVIFWW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:22:57 -0400
Received: from xenotime.net ([66.160.160.81]:37547 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751051AbVIFWW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:22:56 -0400
Date: Tue, 6 Sep 2005 15:22:53 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Esben Nielsen <simlo@phys.au.dk>
cc: Jesper Juhl <jesper.juhl@gmail.com>, "Budde, Marco" <budde@telos.de>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: kbuild & C++
In-Reply-To: <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.50.0509061522260.19596-100000@shark.he.net>
References: <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2005, Esben Nielsen wrote:

> On Tue, 6 Sep 2005, Jesper Juhl wrote:
>
> > On 9/6/05, Budde, Marco <budde@telos.de> wrote:
> > > Hi,
> > >
> > > for one of our customers I have to port a Windows driver to
> > > Linux. Large parts of the driver's backend code consists of
> > > C++.
> > >
> > > How can I compile this code with kbuild? The C++ support
> > > (I have tested with 2.6.11) of kbuild seems to be incomplete /
> > > not working.
> > >
> >
> > That would be because the kernel is written in *C* (and some asm), *not* C++.
> > There /is/ no C++ support.
>
> Which is too bad. You can do stuff much more elegant, effectively and
> safer in C++ than in C. Yes, you can do inheritance in C, but it leaves
> it up to the user to make sure the type-casts are done OK every time. You
> can with macros do some dynamic typing, but not nearly as effectively as
> with templates, and those macros always comes very, very ugly. (Some say
> templates are ugly, but they first become ugly when they are used
> way beyond what you can do with macros.)
>
> I think it can only be a plus to Linux to add C++ support for at least
> out-of-mainline drivers. Adding drivers written in C++ into the mainline
> is another thing.

Please announce it and the URL when you have done it.

-- 
~Randy
