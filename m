Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265830AbUEULtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265830AbUEULtq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 07:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUEULtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 07:49:45 -0400
Received: from gprs214-11.eurotel.cz ([160.218.214.11]:47488 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265830AbUEULtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 07:49:41 -0400
Date: Fri, 21 May 2004 13:49:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>,
       linux-kernel@vger.kernel.org
Subject: Re: swsusp vs. pmdisk [was Re: swsusp: fix swsusp with intel-agp]
Message-ID: <20040521114923.GC10052@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz> <E1BR7pl-0000Br-00@gondolin.me.apana.org.au> <20040521111612.GA976@elf.ucw.cz> <20040521112306.GC976@elf.ucw.cz> <20040521112518.GA1014@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521112518.GA1014@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What about killing pmdisk code, instead?
> > 
> > Its old, its not maintained any more, and it is unneccessary duplicity
> > of swsusp code.
> > 
> > Patrick, in middle of april you claimed you'll have something "by the
> > end of month". Can you either start looking after your code or give up
> > and let me remove it?
> 
> Well if Patrick doesn't have the time to do it, I'd like to maintain
> pmdisk.  It might be a bit out-of-date, by with a bit of work, it
> can easily catch up again since the underlying structure is quite nice.

What if you instead forward-ported same cleanups to swsusp? If done in
reasonably-sized chunks, it would be very welcome.

Of course, having maintained pmdisk in kernel is *way* better than
having umaintained pmdisk in kernel. So feel free to add yourself an
entry in MAINTAINERS file...

Alternatively if you bring pmdisk up-to-date (and maintain it), I
might as well kill swsusp. But I like the name (SWap SUSPend) slightly
better than pmdisk... :-).
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
