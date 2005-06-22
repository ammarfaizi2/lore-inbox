Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262968AbVFVJuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbVFVJuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVFVJrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:47:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262828AbVFVJo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:44:59 -0400
Date: Wed, 22 Jun 2005 02:44:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: miklos@szeredi.hu, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-Id: <20050622024423.66d773f3.akpm@osdl.org>
In-Reply-To: <E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	<20050622004902.796fa977.akpm@osdl.org>
	<E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	<20050622021251.5137179f.akpm@osdl.org>
	<E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > >  We could.  But that would again be overly restrictive.  The goal is to
> > >  make the use of FUSE filesystems for users as simple as possible.  If
> > >  the user has to manage multiple namespaces, each with it's own
> > >  restrictions, it's becoming a very un-user-friendly environment.
> > 
> > I'd have thought that it would be possible to offer the same user interface
> > as you currently have with private namespaces.  Hide any complexity in the
> > userspace tools?  Where's the problem?
> 
> Sorry, I don't get it.

I'm asking you to expand on what the problems would be if we were to
enhance the namespace code as suggested.  What's the "very un-user-friendly
environment", and why cannot it be made more friendly with appropriate
support tools?
