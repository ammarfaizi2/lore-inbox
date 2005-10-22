Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVJVRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVJVRaq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVJVRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:30:46 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:65139 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750852AbVJVRap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:30:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=use8yDIRov1HIn96op7I/KYBc1bxI0LtRcydnH0QQ63MC2vXEfi/h6pyoZOqYBcSShmHDsbjPubHic+qYam0ynVMEqi3b7ppQVl+nkcgiLpr5fJlPKNKmBvywT13ZU+6HfGygjE2R5KtlcWWa5J1lFfEAb9CznkOSPWikgva8Go=  ;
Message-ID: <20051022173044.5903.qmail@web31808.mail.mud.yahoo.com>
Date: Sat, 22 Oct 2005 10:30:44 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached PHYs)
To: Christoph Hellwig <hch@infradead.org>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>, andrew.patterson@hp.com,
       Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20051022105815.GB3027@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Christoph Hellwig <hch@infradead.org> wrote:
> On Sat, Oct 22, 2005 at 12:42:27PM +0200, Stefan Richter wrote:
> > A. Post mock-ups and pseudo code about how to change the core, discuss.
> > B. Set up a scsi-cleanup tree. In this tree,
> >      1. renovate the core (thereby break all command set drivers and
> >         all transport subsystems),
> 
> No way.  Doing things from scatch is a really bad idea.  See how far we came
> with Linux 2.6 scsi vs 2.4 scsi without throwing everything away and break
> the
> world.  Please submit changes to fix _one_ thing at a time and fix all users.
> Repeat until done or you don't care anymore.

No offence Christoph, but who are you again?

There is a clear reason why you among others do not want new architecture.
And that reason is (people) obsoletion.

Such political stance cannot go on forever -- just look at History.
Sooner or later things change and they change radically.  The question
is How prepared are you/we to cope with this (inevitable) change?

Either way, obsoletion or adoption -- think about it, it doesn't only apply
to computer and OS design, it applies to everything.

    Luben




-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
