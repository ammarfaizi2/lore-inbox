Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263543AbTLJN5y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLJN5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:57:53 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:28683
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263595AbTLJN5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:57:52 -0500
Date: Wed, 10 Dec 2003 05:52:12 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <1070652154.14996.10.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So why not do the removal of the inlines to real .c files and quit playing
games with bogus attempts to bleed taint into the inprotectable api?

Clearly it is a game of bait and switch.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 5 Dec 2003, Arjan van de Ven wrote:

> On Fri, 2003-12-05 at 20:09, Valdis.Kletnieks@vt.edu wrote:
> \
> > Interestingly enough, at least on my Fedora box, 'rpm -qi' reports glibc as LGPL,
> > but glibc-kernheaders as GPL, which seems right to me - linking against glibc gives
> > the LGPL semantics as we'd want, but forces userspace that's poking in the kernel
> > to be GPL as a derived work....
> 
> but those headers do not have inlines etc etc 
> just the bare minimum of structures and defines (neither of which result
> in code in the binary )
> 

