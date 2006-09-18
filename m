Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWIRMKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWIRMKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWIRMKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:10:41 -0400
Received: from stanford.columbia.tresys.com ([209.60.7.66]:51294 "EHLO
	twoface.columbia.tresys.com") by vger.kernel.org with ESMTP
	id S965010AbWIRMKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:10:40 -0400
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part
	3/4: introduce new capabilities
From: Joshua Brindle <method@gentoo.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Madore <david.madore@ens.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
In-Reply-To: <20060918120424.GA5370@elf.ucw.cz>
References: <20060910133759.GA12086@clipper.ens.fr>
	 <20060910134257.GC12086@clipper.ens.fr>
	 <1157905393.23085.5.camel@localhost.localdomain>
	 <450451DB.5040104@gentoo.org> <20060917181422.GC2225@elf.ucw.cz>
	 <450DB274.1010404@gentoo.org> <20060917211602.GA6215@clipper.ens.fr>
	 <1158579966.8680.24.camel@twoface.columbia.tresys.com>
	 <20060918120424.GA5370@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 08:12:16 -0400
Message-Id: <1158581536.8680.26.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 14:04 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > The benefits of this are so minuscule and the cost is so high if you are 
> > > > ever to use it that it simply won't happen..
> > > 
> > > I'm withdrawing that patch anyway, in favor of a LSM-style approach,
> > > the "cuppabilities" module (cf. the patch I posted a couple of hours
> > > ago with that word in the title, and I'll be posting a new version in
> > > a day or so, or cf. <URL:
> > > http://www.madore.org/~david/linux/cuppabilities/
> > >  >).  In this case, the relative cost will be lower since the
> > > security_ops->inode_permission() hook is called no matter what.
> > > 
> > 
> > You misunderstand. I don't mean the performance cost is high, I mean the
> > cost of an application to actually be able to run without open() (what I
> > was saying before, static built, no glibc, no conf files, no name
> > lookups, etc). I never see this being used in the real world because of
> > the extreme limitations.
> 
> It is already being used. See config_seccomp.

Where are the users?

