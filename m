Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUA3QhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 11:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbUA3QhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 11:37:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:59045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261885AbUA3QhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 11:37:00 -0500
Date: Fri, 30 Jan 2004 08:36:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: erik@hensema.net, linux-kernel@vger.kernel.org
Subject: Re: Lindent fixed to match reality
In-Reply-To: <m3y8rqh12f.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.58.0401300835180.689@home.osdl.org>
References: <20040129193727.GJ21888@waste.org> <slrnc1irnj.2is.erik@bender.home.hensema.net>
 <m3y8rqh12f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jan 2004, Krzysztof Halasa wrote:
> Erik Hensema <erik@hensema.net> writes:
> 
> >> void *foo(void) {
> >> 
> >>  instead of
> >> 
> >> void *
> >> foo(void) {
> >
> > You just nicely broke 'find . -name *.c | xargs grep ^foo'.
> 
> It was never working with the kernel, so no one can break it.
> Just use a little better pattern or use a tool which parses C code.

Indeed.

Never _ever_ make your source-code look worse because your tools suck. Fix 
the tools instead.

There are tons of tools that index sources properly, so please don't try
to make code look like crap because of using broken things like '^foo'.

		Linus
