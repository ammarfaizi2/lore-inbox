Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269936AbUJMXiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269936AbUJMXiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269934AbUJMXiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:38:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:23683 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269923AbUJMXg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:36:27 -0400
Subject: Re: Announcing Binary Compatibility/Testing
From: "Timothy D. Witham" <wookie@osdl.org>
To: Robert Love <rml@novell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1097709855.5411.20.camel@localhost>
References: <1097705813.6077.52.camel@wookie-zd7>
	 <416DAEB7.4050108@pobox.com>  <1097709855.5411.20.camel@localhost>
Content-Type: text/plain
Organization: Open Source Development Lab, Inc.
Date: Wed, 13 Oct 2004 16:36:32 -0700
Message-Id: <1097710592.6077.79.camel@wookie-zd7>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 19:24 -0400, Robert Love wrote:
> On Wed, 2004-10-13 at 18:39 -0400, Jeff Garzik wrote:
> 
> > Userland ABI compatibility has always been a strongly held value in 
> > Linux, I don't think we would flame any efforts to support that...
> 
> Yah.  With the exception of maybe changing something in /proc (which has
> been rare, and hopefully will never happen with /sys) the kernel-to-user
> ABI is really stable.
> 
   I would tend to agree with that statement.

> I'd venture, in fact, to say that this effort is very important but does
> not affect the kernel at all.  Current "fault" lies in things e.g. like
> the C++ ABI, which is constantly fluctuating (rightly so, to fix bugs,
> but still).
> 
> Any other incompatibility lies in libraries, but we have library
> versioning.  There is nothing wrong with newer libs breaking
> compatibility so long as they have a different soname.  Vendors just
> need to ship compat libs and ISV's need to make sure they request the
> right lib and don't touch internals.
> 

   Part of the problem is knowing which things to request.  I've
envisioned a database that has the matrix of tests and packages  so that 
people like ISV's and system integrators will be able to look
up what has been tested and passed. I think that this database
is the crucial portion of the new development.

   I also expect that part of this process will be the finding that
an ISV used the API in a way that could of got them in trouble 
and that the new version closes that hole.  In this case it would
be a bug on the ISVs side but it would be known long before
it got deployed and the ISV could schedule the development and
testing of the patch to their software as part of their normal 
deployment schedule.


> 	Robert Love
> 

Tim

-- 
Timothy D. Witham - Chief Technology Officer - wookie@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton OR, 97005
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

