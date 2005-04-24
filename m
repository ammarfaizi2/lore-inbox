Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVDXTFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVDXTFv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVDXTFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 15:05:51 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:55383 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262376AbVDXTFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 15:05:47 -0400
Date: Sun, 24 Apr 2005 21:06:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, pavel@ucw.cz, drzeus-list@drzeus.cx,
       torvalds@osdl.org, pasky@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050424190638.GA8044@mars.ravnborg.org>
References: <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <426A7775.60207@drzeus.cx> <20050423220213.GA20519@kroah.com> <20050423222946.GF1884@elf.ucw.cz> <20050423233809.GA21754@kroah.com> <20050424032622.3aef8c9f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424032622.3aef8c9f.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew.

> Andrew has some work to do before he can regain momentum:
> 
> - Which subsystem maintainers will have public git trees?
Planning to have it - when I feel cogito has stabilized a bit.

> - Which maintainers will continue to use bk?
I always liked bk, but will not upgrade to a commercial license.
So bk-kbuild and bk-kconfig will soon dismiss.
 
> Of course, whatever gets done, I'd selfishly prefer that most (or even all)
> subsystem maintainers work the same way and adopt the same work practices.

It will to some respect depend on the nature of the patches that one
want to have included. Working with a set a patches that change often
will call for a quilt based solution. Working with a fairly stable set
of patches will most likely call for a cogito/git solution.

I will await and see what Greg KH or others come up with.

	Sam
