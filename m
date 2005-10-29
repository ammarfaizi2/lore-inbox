Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbVJ2X4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbVJ2X4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 19:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbVJ2X4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 19:56:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:20674 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932758AbVJ2X4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 19:56:17 -0400
Date: Sat, 29 Oct 2005 19:56:13 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Matt Mackall <mpm@selenic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
In-Reply-To: <20051029210643.GR4367@waste.org>
Message-ID: <Pine.LNX.4.58.0510291952350.10073@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
 <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
 <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain>
 <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
 <20051029210643.GR4367@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Oct 2005, Matt Mackall wrote:

> On Sat, Oct 29, 2005 at 05:06:21PM -0400, Steven Rostedt wrote:
> >
> > I already posted this patch to Matt and LKML, but I'm posting it again
> > incase anyone else has this problem using ketchup on 2.6.14 from nothing,
> > and does a google looking for a fix.
>
> This needs a more robust fix. Like perhaps passing --strip-components
> to tar.
>

OK, but I was just adding a fix that was closest to what was already
there.  I can play around with other fixes, and try that out too. The
change I made was just like the current method, but it allowed for all
files to be copied instead of just the non-dot ones.

Also, have you looked at the addition to the version_info for alternate
urls.  I think that this can even be added to do multiple urls, as well
as testing for different filenames in all urls first. ie. .bz2 or .gz,
etc.

-- Steve

