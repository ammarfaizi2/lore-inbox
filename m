Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760143AbWLCWyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760143AbWLCWyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760141AbWLCWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:54:46 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:413 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1760136AbWLCWyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:54:46 -0500
Date: Sun, 3 Dec 2006 23:52:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pavel Machek <pavel@ucw.cz>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
In-Reply-To: <20061203210113.GF9876@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0612032348580.1867@scrub.home>
References: <1165084076.24604.56.camel@localhost.localdomain>
 <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org>
 <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home>
 <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home>
 <20061203102108.GA1724@elf.ucw.cz> <20061203112706.GA12722@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0612031602570.1867@scrub.home> <20061203210113.GF9876@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Dec 2006, Pavel Machek wrote:

> > What exactly is the pita here? Al only came up with some rather 
> > theoretical problems with no practical relevance.
> 
> Lack of type-checking in timers is ugly.

It's a matter of perspective, a bit more type checking would be nice, but 
breaking the API just for that is ugly as well. Unless there is a bad need 
for it, I don't think it's worth it...

bye, Roman
