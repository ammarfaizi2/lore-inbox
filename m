Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTJGOEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbTJGOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:04:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30475 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262356AbTJGOEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:04:20 -0400
Date: Tue, 7 Oct 2003 16:03:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andre Hedrick <andre@linux-ide.org>
cc: David Woodhouse <dwmw2@infradead.org>, Larry McVoy <lm@bitmover.com>,
       Pascal Schmidt <der.eremit@email.de>, <linux-kernel@vger.kernel.org>
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <Pine.LNX.4.10.10310070412500.2266-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0310071449370.17548-100000@serv>
References: <Pine.LNX.4.10.10310070412500.2266-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 Oct 2003, Andre Hedrick wrote:

> "EXPORT_SYMBOL_GPL" is a license enforcement tool, period.
> 
> Any driver using a caller wrappered by "EXPORT_SYMBOL_GPL" will have the
> function fail quietly and restrict functionality.

If I understand you correctly, you cannot tell me how EXPORT_SYMBOL_GPL 
is an additional restriction according to the GPL.
OTOH what's wrong with enforcing a license?

>  Restricting
> functionality is a means to disable drivers period.  These very same
> functions in question are required for any other driver to operate.
> 
> That makes them part of the API for operational compatibility.
> The API is described exclusively by the snapshot version of a given
> kernel.

What gave you the right to use the API or the implementation of this API 
in first place?

> So under copyright case law, where GPL has never been,

Could you please explain, what you're trying to say here?

> there are rulings
> and history describing what an API is, how it can not be protected, and
> determinations of fair use based on legal rulings.
> 
> Now if one is forced to disable EXPORT_SYMBOL_GPL and redistribute the
> modified kernel source as a single object, there is nothing anybody can do
> to stop that process.

Why would you be forced to disable EXPORT_SYMBOL_GPL? You can do that of 
course as long as you respect the conditions in the GPL, but that wouldn't 
require modifying EXPORT_SYMBOL_GPL.

> A simple solution is to publish an EXPORT_SYMBOL shim so one would not
> be subject to the issues of distribution clauses.  The SHIM is
> GPL-compatable and it provides clear exports of the API snapshot.
> 
> Separtion of the logical .c shim module driver and the decoupled .h is
> making the boundary clear.

Could you please explain how your binary module can be "reasonably 
considered independent", so that you don't have to distribute it under the 
GPL? How are boundaries of any importance, if you not allowed to use the 
GPL part in first place? Alternatively what gives you the right to ignore 
the will of the copyright owner and distribute the GPL part under your own 
conditions?

> However this is a was of time because neither you (best guess) and the
> majority here have ever paid to have the license explained and how it is
> subject to actual copyright laws.  In the past I was one of the folks
> shouting opinions not facts.  The facts are rude eye openers.

Well, what I have seen so far is that your logic stinks mightily and you 
are twisting reality to your own needs and on this way showing absolutely 
no respect for the work of others.

bye, Roman

