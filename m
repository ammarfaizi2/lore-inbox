Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVBIRbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVBIRbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 12:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVBIRbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 12:31:23 -0500
Received: from modemcable096.213-200-24.mc.videotron.ca ([24.200.213.96]:37768
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261858AbVBIRbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 12:31:14 -0500
Date: Wed, 9 Feb 2005 12:30:54 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Larry McVoy <lm@bitmover.com>
cc: Alexandre Oliva <aoliva@redhat.com>, Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050209155113.GA10659@bitmover.com>
Message-ID: <Pine.LNX.4.61.0502091219430.7836@localhost.localdomain>
References: <20050204183922.GC27707@bitmover.com> <20050204200507.GE5028@deep-space-9.dsnet>
 <20050204201157.GN27707@bitmover.com> <20050204214015.GF5028@deep-space-9.dsnet>
 <20050204233153.GA28731@electric-eye.fr.zoreil.com> <20050205193848.GH5028@deep-space-9.dsnet>
 <20050205233841.GA20875@bitmover.com> <20050208154343.GH3537@crusoe.alcove-fr>
 <20050208155845.GB14505@bitmover.com> <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
 <20050209155113.GA10659@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005, Larry McVoy wrote:

> On Wed, Feb 09, 2005 at 05:06:02AM -0200, Alexandre Oliva wrote:
> > So you've somehow managed to trick most kernel developers into
> > granting you power over not only the BK history
> 
> It's exactly the same as a file system.  If you put some files into a
> file system does the file system creator owe you the knowledge of how
> those files are maintained in the file system?

No, this is not a good analogy at all.

If I don't want to use a certain filesystem, I mount it and copy the 
files over to another filesystem.  What users are interested in are the 
files themselves of course, and the efficiency with which the filesystem 
handles those files.  BK is the efficient filesystem here, but anyone 
should be able to freely copy files over to another filesystem without 
any need for the filesystem internals knowledge.  If the target 
filesystem is 8.3 without lowercase support then so be it and people 
will need to use a separate file to hold the extra details that cannot 
berepresented natively in the target filesystem.  But absolutely 0% of 
the information is lost.

Again, the BK value is in the efficiency and reliability it has to 
handle a tree like the Linux kernel, not in the Linux kernel tree.  It's 
not necessary for you to give away that value in order to provide the 
simple information needed to reconstruct the Linux tree structure as 
people are asking.


Nicolas
