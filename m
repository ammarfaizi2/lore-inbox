Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDTKLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDTKLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWDTKLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:11:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33439 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750831AbWDTKLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:11:18 -0400
Date: Thu, 20 Apr 2006 03:10:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: torvalds@osdl.org, agk@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
Message-Id: <20060420031013.68cff2cf.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0604201302090.29821@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
	<20060420025953.577e2225.akpm@osdl.org>
	<Pine.LNX.4.58.0604201302090.29821@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> Hi Andrew,
> 
> Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
> > > The commit aa14edeb994f8f7e223d02ad14780bf2fa719f6d "[PATCH] device-mapper 
> > >  snapshot: load metadata on creation" breaks userspace and is blocking us 
> > >  from moving to the 2.6.16 series kernel. Debian doesn't have the 
> > >  new required LVM version in stable yet. Is the change intentional?
>  
> On Thu, 20 Apr 2006, Andrew Morton wrote:
> > The changelog said
> > 
> >   If you're using lvm2, for this patch to work properly you should update
> >   to lvm2 version 2.02.01 or later and device-mapper version 1.02.02 or
> >   later.
> > 
> > Which was pretty bad of us.  I hope LVM 2.02.01 userspace is
> > back-compatible with older kernels?
> 
> Yeah, I know, but that still leaves us in an unfortunate situation as the 
> 2.6.16 series has security fixes that are not AFAIK in 2.6.15. Anyway, if 
> the change is intentional and approved, I guess we'll just have to live 
> with it. Thanks!
> 

Well I wouldn't say it was "approved".  It was disapproved of and
grudgingly accepted :(

More info here: http://lkml.org/lkml/2006/1/23/130

