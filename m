Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVAZXtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVAZXtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVAZXs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:48:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:51921 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262134AbVAZT33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:29:29 -0500
Date: Wed, 26 Jan 2005 11:28:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olh@suse.de>
cc: Jesse Pollard <jesse@cats-chateau.net>, linux-os <linux-os@analogic.com>,
       John Richard Moser <nigelenki@comcast.net>, dtor_core@ameritech.net,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050126191501.GA26920@suse.de>
Message-ID: <Pine.LNX.4.58.0501261127280.2362@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <41F6A45D.1000804@comcast.net> <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
 <05012609151500.16556@tabby> <Pine.LNX.4.58.0501260803360.2362@ppc970.osdl.org>
 <20050126191501.GA26920@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Jan 2005, Olaf Hering wrote:
> 
> And, did that nice interface help at all? No, it did not.
> Noone made seqfile mandatory in 2.6.

Sure it helped. We didn't make it mandatory, but new stuff ends up being 
written with it, and old stuff _does_ end up being converted to it.

> Now we have a few nice big patches to carry around because every driver
> author had its own proc implementation. Well done...

Details, please?

		Linus
