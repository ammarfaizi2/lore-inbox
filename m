Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263257AbTEIOZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 10:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTEIOZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 10:25:51 -0400
Received: from stine.vestdata.no ([195.204.68.10]:8621 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id S263257AbTEIOZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 10:25:50 -0400
Date: Fri, 9 May 2003 16:37:15 +0200
From: Ragnar =?unknown-8bit?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030509143715.GC16354@vestdata.no>
References: <200305081546_MC3-1-3809-363E@compuserve.com> <03050908530400.11221@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03050908530400.11221@tabby>
User-Agent: Mutt/1.5.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 08:53:04AM -0500, Jesse Pollard wrote:
> On Thursday 08 May 2003 14:43, Chuck Ebbert wrote:
> > > Have you tried catching the display IO ???
> >
> >   Not in a million years -- display drivers work by pure magic AFAIC.
> >
> > > HSM has existed on UNIX based machines for a long time.
> >
> >   Show me three HSM implementations for Linux and I'll show you three
> > different mechanisms. :)
> 
> Actually... I think they all use the same one (Even the Solaris/IRIX/Cray ones
> do that). All of them provide a filesystem interface via VFS. The Linux ones
> were implemented via the "userfs" core or NFS.

I'm not sure what you mean by "via" VFS, but most HSM implementations on linux 
require extra interfaces and special support in the filesystem (XDSM or propriatary).

The only exceptions I know are openXDSM which was intended to be a
generic interface in the VFS-layer (but we never got time to implement
it) and a implementation based on stackable filesystem.

I don't know if the later is actually in use anywere, or if it is
abandoned.


-- 
Ragnar Kjørstad
Zet.no
