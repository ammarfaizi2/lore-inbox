Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbTCQSRT>; Mon, 17 Mar 2003 13:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbTCQSRJ>; Mon, 17 Mar 2003 13:17:09 -0500
Received: from havoc.daloft.com ([64.213.145.173]:45467 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261845AbTCQSQU>;
	Mon, 17 Mar 2003 13:16:20 -0500
Date: Mon, 17 Mar 2003 13:27:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030317182709.GA27116@gtf.org>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com> <1047923841.1600.3.camel@laptop.fenrus.com> <20030317182040.GA2145@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030317182040.GA2145@louise.pinerecords.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 07:20:40PM +0100, Tomas Szepe wrote:
> > [arjanv@redhat.com]
> > 
> > I've attached a patch against 2.4.21pre5.
> 
> So what happens now?
> 
> Is this critical enough for 2.4.21 to go out?  Or can it wait like
> some other fairly serious stuff such as the ext3 fixes?  What about
> the current state of IDE?
> 
> Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> or 2.4.20.1 with only the critical stuff applied?

There shouldn't be a huge need to rush 2.4.21 as-is, really.  If you
want an immediate update, get the fix from your vendor.

Plus, it's a local root hole, and there are still tons of those left
out there to squash.

	Jeff



