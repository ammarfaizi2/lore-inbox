Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTLDUib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 15:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTLDUia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 15:38:30 -0500
Received: from pop.gmx.de ([213.165.64.20]:25236 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263526AbTLDUi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 15:38:29 -0500
Date: Thu, 4 Dec 2003 21:38:28 +0100 (MET)
From: "Peter Bergmann" <bergmann.peter@gmx.net>
To: Jens Axboe <axboe@suse.de>
Cc: maze@cela.pl, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031204184248.GJ1086@suse.de>
Subject: Re: oom killer in 2.4.23
X-Priority: 3 (Normal)
X-Authenticated: #13246506
Message-ID: <956.1070570308@www27.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > effect is still unchanged. 
> > processes get killed by VM and not oom_kikll.c
> > 
> > any hints ??
> 
> You probably want to look at the change to
> vmscan.c:try_to_free_pages_zone().
> 
> -- 
> Jens Axboe

I did, but my vm knolege is rather limited.
I don't really know really know _where_ to place 
out_of_memory() in the new try_to_free_pages_zone()...
and what  other changes would be necessary in vmscan.c.

My try & error approach did not succeed.

I would be really glad if someone (aa may be :) could
provide the information where/how to place the call for a custom
(or the old) oom killer -  if it's really that simple ...

cheers,
pet


-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


