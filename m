Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUCBXCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUCBXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:01:45 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:21492 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S262274AbUCBXAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:00:20 -0500
Date: Tue, 2 Mar 2004 16:00:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040302230018.GL20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net> <20040302223143.GE1225@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302223143.GE1225@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 11:31:43PM +0100, Pavel Machek wrote:

> Hi!
> 
> > > Tom Rini wrote:
> > > >Hello.  The following interdiff kills kgdb_serial in favor of function
> > > >names.  This only adds a weak function for kgdb_flush_io, and documents
> > > >when it would need to be provided.
> > > 
> > > It looks like you are also dumping any notion of building a kernel that can 
> > > choose which method of communication to use for kgdb at run time.  Is this 
> > > so?
> > 
> > Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> > you try and allow for any 2 of 3 methods.
> 
> I do not think that having kgdb_serial is so ugly. Are there any other
> uglyness associated with that?

More precisely:
http://lkml.org/lkml/2004/2/11/224

-- 
Tom Rini
http://gate.crashing.org/~trini/
