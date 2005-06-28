Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVF1PRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVF1PRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVF1PRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:17:36 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45213 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262033AbVF1PR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:17:29 -0400
Message-Id: <200506281344.j5SDixiH003441@laptop11.inf.utfsm.cl>
To: mjt@nysv.org (Markus =?ISO-8859-1?Q?=20T=F6rnqvist?=)
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from mjt@nysv.org (Markus =?ISO-8859-1?Q?=20T=F6rnqvist?=) 
   of "Mon, 27 Jun 2005 12:21:38 +0300." <20050627092138.GD11013@nysv.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 28 Jun 2005 09:44:59 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 28 Jun 2005 11:16:31 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus   Törnqvist <mjt@nysv.org> wrote:
> On Thu, Jun 23, 2005 at 11:34:50PM -0400, Horst von Brand wrote:
> >David Masover <ninja@slaphack.com> wrote:
> >> I think Hans (or someone) decided that when hardware stops working, it's
> >> not the job of the FS to compensate, it's the job of lower layers, or
> >> better, the job of the admin to replace the disk and restore from
> >> backups.

> >Handling other people's data this way is just reckless irresponsibility.
> >Sure, you can get high performance if you just forego some of your basic
> >responsibilities.

> Your honest-to-bog opinion is that the FS vendor is responsible for
> the admin not taking backups or the hardware vendor shipping crap?

No. But just relying on perfect hardware and concientious sysadmins is
reckless. Hardware /is/ flaky, sysadmins /are/ (sometimes) lazy (and
besides, today they are increasingly just plain Joe Sixpack users). Also,
backing up a few hundred GiB is /not/ fun, and then keeping track of all
the backups is messy.

Also, I'm not claiming that they are /solely/ responsible, but not having
the filesystem fall apart utterly every time some bug breaths on it /is/ a
requirement.

> *still trying to understand how that can be*

You haven't been around too much yet, do you?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
