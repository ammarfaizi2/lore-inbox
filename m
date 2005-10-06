Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVJFDl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJFDl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 23:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJFDl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 23:41:28 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43423 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751114AbVJFDl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 23:41:27 -0400
Message-Id: <200510060306.j96365YK009019@inti.inf.utfsm.cl>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Message from Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
   of "Thu, 06 Oct 2005 00:03:09 +0100." <20051005230309.GO10538@lkcl.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 05 Oct 2005 23:06:05 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Wed, Oct 05, 2005 at 02:47:27PM -0400, Horst von Brand wrote:
> > Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > On Wed, Oct 05, 2005 at 01:24:12PM +0400, Nikita Danilov wrote:
> > > > Marc Perkel writes:

[...]

> > > > Because in Unix a name is not an attribute of a file.

> > >  there is no excuse.

> > It's not an excuse, it's part of a coherent view of how things work. Just
> > as Netware used to have its, and DOS had its (sort of). As the world view
> > underneath Unix, it is darn hard to "fix".
> > 
> > [This discussion sounds quite a lot like it is /you/ who needs "fixing",
> >  i.e., first wrap your head around Unix' ways...]

>  asking "ordinary" people to do that is unrealistic: surely you know
>  that?

And asking ordinary people to understand the (much more complex and opaque)
idea of "inheriting permissions from directories (sometimes, unless...)" is
surely much easier...

>  i just spent two hours helping a friend who wasn't familiar
>  with the concept of "give root password for maintenance or
>  press ctrl-d" they'd been pressing ctrl-d because it said so
>  and now i'm going to have a 5-hour round-trip journey and possibly
>  an overnight stay to sort out the mess.

Any suggestion for a better message?

[...]

>  example permissions (from postfix.te, policy source version 18):
> 
> 	allow postfix_$1_t { sbin_t bin_t }:dir r_dir_perms;
> 	allow postfix_$1_t { bin_t usr_t }:lnk_file { getattr read };
> 	allow postfix_$1_t shell_exec_t:file rx_file_perms;
> 
>  i am confident enough with selinux to say that those are file
>  and directory permissions.

OK, now I know for sure you are just an elaborate troll. SELinux is
/harder/ to grasp than Unix permissions, and /requires/ you to grasp them
as foundation.

[...]

> > >  in what way is it possible for linux to fully support the NTFS
> > >  filesystem?
> > 
> > If you ask me, preferably not at all, just let that unholy mess quietly go
> > the way of the dinosaurs. Sadly, interoperability is required at times,
> > so...
> 
>  *sigh*, tell me about it.  well, when reactos gets its NTFS driver, i
>  will be sure to let you know.  i promise :)

Great. Just keep in mind that time wasted on LKML is time taken away from
NTFS for ReactOS.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
