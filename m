Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVJESsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVJESsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 14:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVJESsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 14:48:12 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7070 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030322AbVJESsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 14:48:11 -0400
Message-Id: <200510051847.j95IlRTS012444@laptop11.inf.utfsm.cl>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Nikita Danilov <nikita@clusterfs.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Message from Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
   of "Wed, 05 Oct 2005 10:56:53 +0100." <20051005095653.GK10538@lkcl.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 05 Oct 2005 14:47:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 05 Oct 2005 14:47:28 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Wed, Oct 05, 2005 at 01:24:12PM +0400, Nikita Danilov wrote:
> > Marc Perkel writes:

> > [...]
> > 
> >  > Right - that's Unix "inside the box" thinking. The idea is to make the 
> >  > operating system smarter so that the user doesn't have to deal with 
> >  > what's computer friendly - but reather what makes sense to the user. 
> >  >  From a user's perspective if you have not rights to access a file then 
> >  > why should you be allowed to delete it?

> > Because in Unix a name is not an attribute of a file.

>  there is no excuse.

It's not an excuse, it's part of a coherent view of how things work. Just
as Netware used to have its, and DOS had its (sort of). As the world view
underneath Unix, it is darn hard to "fix".

[This discussion sounds quite a lot like it is /you/ who needs "fixing",
 i.e., first wrap your head around Unix' ways...]

>  selinux has already provided an alternative that is similar to NW
>  file permissions.

Nope. SELinux provides MAC, i.e., mechanisms by which system-wide policy
(not the random owner of an object) ultimately decides what operations to
allow. That is not "file permissions". And yes, this is quite un-Unix-like.

[...]

>  in what way is it possible for linux to fully support the NTFS
>  filesystem?

If you ask me, preferably not at all, just let that unholy mess quietly go
the way of the dinosaurs. Sadly, interoperability is required at times,
so...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

