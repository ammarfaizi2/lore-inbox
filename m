Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUCBWLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUCBWLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:11:18 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:7863 "EHLO fed1mtao06.cox.net")
	by vger.kernel.org with ESMTP id S261993AbUCBWLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:11:15 -0500
Date: Tue, 2 Mar 2004 15:11:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: George Anzinger <george@mvista.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kgdb-bugreport@lists.sourceforge.net,
       "Amit S. Kale" <amitkale@emsyssoft.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [Kgdb-bugreport] [PATCH] Kill kgdb_serial
Message-ID: <20040302221106.GH20227@smtp.west.cox.net>
References: <20040302213901.GF20227@smtp.west.cox.net> <40450468.2090700@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40450468.2090700@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 02:02:16PM -0800, George Anzinger wrote:

> Tom Rini wrote:
> >Hello.  The following interdiff kills kgdb_serial in favor of function
> >names.  This only adds a weak function for kgdb_flush_io, and documents
> >when it would need to be provided.
> 
> It looks like you are also dumping any notion of building a kernel that can 
> choose which method of communication to use for kgdb at run time.  Is this 
> so?

Yes, as this is how Andrew suggested we do it.  It becomes quite ugly if
you try and allow for any 2 of 3 methods.

-- 
Tom Rini
http://gate.crashing.org/~trini/
