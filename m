Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVAGRlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVAGRlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVAGRkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:40:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:20152 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261369AbVAGRiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:38:10 -0500
Date: Fri, 7 Jan 2005 09:38:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Martin Mares <mj@ucw.cz>
Cc: Chris Wright <chrisw@osdl.org>, Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107093808.C2357@build.pdx.osdl.net>
References: <20050107162902.GA7097@ucw.cz> <200501071636.j07Gateu018841@localhost.localdomain> <20050107170603.GB7672@ucw.cz> <20050107092918.B2357@build.pdx.osdl.net> <20050107173229.GA9794@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050107173229.GA9794@ucw.cz>; from mj@ucw.cz on Fri, Jan 07, 2005 at 06:32:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Mares (mj@ucw.cz) wrote:
> Hello!
> 
> > Yes, SETPCAP became a gaping security hole.  Recall the sendmail hole.
> 
> Hmmm, I don't remember now, could you give me some pointer, please?

Sure, the Wagner/Chen paper on setuid demystified has some references to
it IIRC.  http://www.cs.ucdavis.edu/~hchen/paper/usenix02.ps

> > This won't work, you can't increase the bset, which is hardcoded to
> > leave out SETPCAP.  Also, init is hard coded to start without SETPCAP.
> 
> If I read the source correctly, init is allowed to increase the bset,
> the other processes aren't.

Yes, you're right I forgot about that.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
