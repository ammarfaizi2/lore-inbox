Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVIMPoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVIMPoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVIMPoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:44:46 -0400
Received: from xenotime.net ([66.160.160.81]:22726 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964808AbVIMPop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:44:45 -0400
Date: Tue, 13 Sep 2005 08:44:44 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: iSteve <isteve@rulez.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "" <linux-kernel@vger.kernel.org>
Subject: Re: query_modules syscall gone? Any replacement?
In-Reply-To: <4326F093.80206@rulez.cz>
Message-ID: <Pine.LNX.4.50.0509130835120.7614-100000@shark.he.net>
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
 <4326DE0E.2060306@rulez.cz> <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
 <4326F093.80206@rulez.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, iSteve wrote:

> > Nope, they are not prevented.  However, there is a Tainted flag
> > that is set when one is loaded (and that flag is never cleared).
> >
>
> Okay, I've been wrong in my conclusion and I gotta read some fine manual
> about how the modules actually work -- could you recommend me some in
> particular?

Nope, there is precious little doc about modules, especially
in 2.6.

There is a FAQ, but I doubt that it answers many of your
questions.
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/FAQ

You could try LDD3, but I don't see much there that would help
you either.
  http://lwn.net/Kernel/LDD3/

> >>  - /proc/modules and /sys/module interface doesn't by far supply what
> >>query_module could do
> >
> > Can you state succinctly exactly what you are trying to do?
>
> I would like to be able to query symbols of a loaded module, get list of
> and list of dependencies of loaded module from an app, preferably
> without having to parse a file...

No, no syscall to do that.  Looks like it will require reading
and parsing files.

And you answered my "what" question clearly, so I have one more.
Why?  for what purpose, to what end?  What are you tring to
accomplish?

Thanks,
-- 
~Randy
