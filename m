Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVBJHBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVBJHBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVBJHBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:01:43 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48016 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262032AbVBJHBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:01:41 -0500
Message-Id: <200502100544.j1A5ingN009423@laptop11.inf.utfsm.cl>
To: Nicolas Pitre <nico@cam.org>
cc: Larry McVoy <lm@bitmover.com>, Alexandre Oliva <aoliva@redhat.com>,
       Stelian Pop <stelian@popies.net>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto 
In-Reply-To: Message from Nicolas Pitre <nico@cam.org> 
   of "Wed, 09 Feb 2005 12:30:54 CDT." <Pine.LNX.4.61.0502091219430.7836@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 10 Feb 2005 02:44:49 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 10 Feb 2005 03:22:03 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org> said:
> On Wed, 9 Feb 2005, Larry McVoy wrote:
> > On Wed, Feb 09, 2005 at 05:06:02AM -0200, Alexandre Oliva wrote:
> > > So you've somehow managed to trick most kernel developers into
> > > granting you power over not only the BK history

> > It's exactly the same as a file system.  If you put some files into a
> > file system does the file system creator owe you the knowledge of how
> > those files are maintained in the file system?

> No, this is not a good analogy at all.

It is just fine.

> If I don't want to use a certain filesystem, I mount it and copy the 
> files over to another filesystem.  What users are interested in are the 
> files themselves of course, and the efficiency with which the filesystem 
> handles those files.  BK is the efficient filesystem here, but anyone 
> should be able to freely copy files over to another filesystem without 
> any need for the filesystem internals knowledge.  If the target 
> filesystem is 8.3 without lowercase support then so be it and people 
> will need to use a separate file to hold the extra details that cannot 
> berepresented natively in the target filesystem.  But absolutely 0% of 
> the information is lost.

But what you want is not the files, but the whole history of the filesystem
(what was written/changed/deleted when).

> Again, the BK value is in the efficiency and reliability it has to 
> handle a tree like the Linux kernel, not in the Linux kernel tree.  It's 
> not necessary for you to give away that value in order to provide the 
> simple information needed to reconstruct the Linux tree structure as 
> people are asking.

linux-2.6.10.tar.bz2, and you even get the -bk patches!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
