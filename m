Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFSUUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFSUUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 16:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFSUUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 16:20:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261316AbVFSUUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 16:20:40 -0400
Date: Sun, 19 Jun 2005 13:20:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Chris Wright <chrisw@osdl.org>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org,
       "Rickard E. (Rik) Faith" <faith@redhat.com>,
       Rik Faith <faith@cs.unc.edu>, linux-audit@redhat.com
Subject: Re: [PATCH] Small kfree cleanup, save a local variable.
Message-ID: <20050619202018.GO9046@shell0.pdx.osdl.net>
References: <Pine.LNX.4.62.0506192129300.2832@dragon.hyggekrogen.localhost> <20050619201354.GY9153@shell0.pdx.osdl.net> <9a874849050619131941278fc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a874849050619131941278fc4@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl (jesper.juhl@gmail.com) wrote:
> On 6/19/05, Chris Wright <chrisw@osdl.org> wrote:
> > * Jesper Juhl (juhl-lkml@dif.dk) wrote:
> > > Here's a patch with a small improvement to kernel/auditsc.c .
> > > There's no need for the local variable  struct audit_entry *e  ,
> > > we can just call kfree directly on container_of() .
> > > Patch also removes an extra space a little further down in the file.
> > 
> > Please Cc: linux-audit@redhat.com on audit patches.
> 
> I didn't find that address in MAINTAINERS nor in the source file. I
> had no idea it existed. Perhaps it ought to be listed in MAINTAINERS
> somewhere...

Ahh, good point, that needs to be fixed.

thanks,
-chris
