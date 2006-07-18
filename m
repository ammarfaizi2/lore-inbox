Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWGRA1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGRA1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGRA1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:27:45 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:4819 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751256AbWGRA1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:27:44 -0400
Message-Id: <200607180026.k6I0Qo1m010430@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Jeff Mahoney <jeffm@suse.com>, 7eggert@gmx.de,
       Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Mon, 17 Jul 2006 14:03:09 MST." <44BBFB0D.6040105@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 17 Jul 2006 20:26:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 17 Jul 2006 20:26:59 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
> Jeff Mahoney wrote:
> > Hans Reiser wrote:
> > >Jeff Mahoney wrote:
> > >>1) Because then the behavior of /proc/fs/reiserfs/ would be
> > >>inconsistent. Devices that contain slashes end up being one level deeper
> > >>than other devices, which is silly and a userspace visible change.
> >
> > >And you think translating / to ! is less work for user space?
> >
> >
> > A one line s#/#!# to access devices they couldn't before versus now
> > having to deal with going deeper into a tree for no real reason? Yes,
> > I do.

> I am willing to bet that perl can tree iterate with one line of code....

;-)

> Please read the Hideous Name by Rob Pike.

Interesting read.

>                                           You are making it more hideous.

By insisting that something that is /not/ a directory /is/ written as such?
Sorry, they are asking for exactly the opposite.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
