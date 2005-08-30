Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVH3XhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVH3XhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVH3XhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:37:17 -0400
Received: from smtp.istop.com ([66.11.167.126]:49094 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751450AbVH3XhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:37:16 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH 1 of 4] Configfs is really sysfs
Date: Wed, 31 Aug 2005 09:37:15 +1000
User-Agent: KMail/1.7.2
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
References: <200508310854.40482.phillips@istop.com> <20050830231307.GE22068@insight.us.oracle.com> <20050830162846.5f6d0a53.akpm@osdl.org>
In-Reply-To: <20050830162846.5f6d0a53.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310937.15344.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 09:28, Andrew Morton wrote:
> Joel Becker <Joel.Becker@oracle.com> wrote:
> > On Wed, Aug 31, 2005 at 08:54:39AM +1000, Daniel Phillips wrote:
> > > But it would be stupid to forbid users from creating directories in
> > > sysfs or to forbid kernel modules from directly tweaking a configfs
> > > namespace.  Why should the kernel not be able to add objects to a
> > > directory a user created? It should be up to the module author to
> > > decide these things.
> >
> > 	This is precisely why configfs is separate from sysfs.  If both
> > user and kernel can create objects, the lifetime of the object and its
> > filesystem representation is very complex.  Sysfs already has problems
> > with people getting this wrong.  configfs does not.
> > 	The fact that sysfs and configfs have similar backing stores
> > does not make them the same thing.
>
> Sure, but all that copying-and-pasting really sucks.  I'm sure there's some
> way of providing the slightly different semantics from the same codebase?

I will have that patch ready later this week.

Regards,

Daniel
