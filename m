Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVAZXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVAZXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVAZXud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:50:33 -0500
Received: from news.suse.de ([195.135.220.2]:9139 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262167AbVAZTin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:38:43 -0500
Date: Wed, 26 Jan 2005 20:38:39 +0100
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesse Pollard <jesse@cats-chateau.net>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050126193839.GA29324@suse.de>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com> <05012609151500.16556@tabby> <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org> <20050126191501.GA26920@suse.de> <Pine.LNX.4.58.0501261127280.2362@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501261127280.2362@ppc970.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Jan 26, Linus Torvalds wrote:

> 
> 
> On Wed, 26 Jan 2005, Olaf Hering wrote:
> > 
> > And, did that nice interface help at all? No, it did not.
> > Noone made seqfile mandatory in 2.6.
> 
> Sure it helped. We didn't make it mandatory, but new stuff ends up being 
> written with it, and old stuff _does_ end up being converted to it.

2.5 was the right time to enforce it.

> > Now we have a few nice big patches to carry around because every driver
> > author had its own proc implementation. Well done...
> 
> Details, please?

You did it this way:
http://linux.bkbits.net:8080/linux-2.5/cset@4115cba3UCrZo9SnkQp0apTO3SghJQ
