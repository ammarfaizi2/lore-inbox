Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUCBWcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUCBWcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:32:31 -0500
Received: from gprs40-190.eurotel.cz ([160.218.40.190]:63088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262126AbUCBWby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:31:54 -0500
Date: Tue, 2 Mar 2004 23:31:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Tom Rini <trini@kernel.crashing.org>
Cc: George Anzinger <george@mvista.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040302223143.GE1225@elf.ucw.cz>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com> <20040302221106.GH20227@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040302221106.GH20227@smtp.west.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Tom Rini wrote:
> > >Hello.  The following interdiff kills kgdb_serial in favor of function
> > >names.  This only adds a weak function for kgdb_flush_io, and documents
> > >when it would need to be provided.
> > 
> > It looks like you are also dumping any notion of building a kernel that can 
> > choose which method of communication to use for kgdb at run time.  Is this 
> > so?
> 
> Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
> you try and allow for any 2 of 3 methods.

I do not think that having kgdb_serial is so ugly. Are there any other
uglyness associated with that?
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
