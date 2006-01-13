Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422898AbWAMT5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWAMT5T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWAMT5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:57:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54714 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1422898AbWAMT46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:56:58 -0500
Date: Fri, 13 Jan 2006 20:56:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
Subject: Re: [patch 00/62] sem2mutex: -V1
Message-ID: <20060113195658.GA3780@elte.hu>
References: <20060113124402.GA7351@elte.hu> <200601131400.00279.baldrick@free.fr> <20060113134412.GA20339@elte.hu> <200601131925.34971.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601131925.34971.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Oeser <ioe-lkml@rameria.de> wrote:

> Hi there,
> 
> On Friday 13 January 2006 14:44, Ingo Molnar wrote:
> >     - it should stay a semaphore (if it's a genuine counting 
> >       semaphore)
> > 
> >     - or it should get converted to a completion (if it's used as
> >       a completion)
> > 
> >     - or it should get converted to struct work (if it's used as a 
> >       workflow synchronizer).
> 
> Could we get for each of these and a mutex:
> 
>  - description 
>  - common use case
>  - small argument why this and nothing else should be used there

like ... Documentation/mutex-design.txt?

	Ingo
