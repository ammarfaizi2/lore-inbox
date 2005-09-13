Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVIMQww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVIMQww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVIMQww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:52:52 -0400
Received: from xenotime.net ([66.160.160.81]:30692 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964887AbVIMQwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:52:45 -0400
Date: Tue, 13 Sep 2005 09:52:41 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: iSteve <isteve@rulez.cz>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, "" <linux-kernel@vger.kernel.org>
Subject: Re: query_modules syscall gone? Any replacement?
In-Reply-To: <4326FDA2.90808@rulez.cz>
Message-ID: <Pine.LNX.4.50.0509130943130.3527-100000@shark.he.net>
References: <4KSFY-2pO-17@gated-at.bofh.it> <E1EDpQq-0000iV-Oe@be1.lrz>
 <4326DE0E.2060306@rulez.cz> <Pine.LNX.4.50.0509130813010.7614-100000@shark.he.net>
 <4326F093.80206@rulez.cz> <Pine.LNX.4.50.0509130835120.7614-100000@shark.he.net>
 <4326FDA2.90808@rulez.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, iSteve wrote:

> >>I would like to be able to query symbols of a loaded module, get list of
> >>and list of dependencies of loaded module from an app, preferably
> >>without having to parse a file...
> >
> >
> > No, no syscall to do that.  Looks like it will require reading
> > and parsing files.
> >
> > And you answered my "what" question clearly, so I have one more.
> > Why?  for what purpose, to what end?  What are you tring to
> > accomplish?
>
> The files so far provided still do not seem to give these informations
> though...

Right, I don't see dependency ("requires") info there, just "using" info.

> Part of the project I'm working on -- click-click ui for handling
> modules, with some perks: in this case, getting info about loaded
> modules that I hoped to obtain via query_module.
>
> Oh, and one more question: There were no particular issues with
> query_module, or were they? If there weren't, why wasn't it kept?

I don't recall.
You can try searching the lkml archives or asking Rusty Russell:

MODULE SUPPORT
P:	Rusty Russell
M:	rusty@rustcorp.com.au
L:	linux-kernel@vger.kernel.org
S:	Maintained

One quick search produced this, but it doesn't help you any:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108355087015676&w=2

-- 
~Randy
