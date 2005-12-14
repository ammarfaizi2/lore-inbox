Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVLNV1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVLNV1Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVLNV1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:27:24 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28576 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932356AbVLNV1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:27:24 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200512150013.29549.a1426z@gawab.com>
References: <200512150013.29549.a1426z@gawab.com>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 22:27:18 +0100
Message-Id: <1134595639.9442.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 00:13 +0300, Al Boldi wrote:
> Greg KH wrote:
> > For people to think that the kernel developers are just "too dumb" to 
> > make a stable kernel api (and yes, I've had people accuse me of this 
> > many times to my face[1]) shows a total lack of understanding as to 
> > _why_ we change the in-kernel api all the time.  Please see
> > Documentation/stable_api_nonsense.txt for details on this. 
> 
> I read this doc, and it doesn't make your case any clearer, on the contrary!
> 
> But first, your work to the kernel represents a not so dumb contribution, 
> especially the replacement of devfs.  Thanks!
> 
> Now, to call a stable api nonsense is nonsense.  Really, only a _stable_ api 
> is worth to be considered an API.  Think about it.

a stable api/abi for the linux kernel would take at least 2 years to
develop. The current API is not designed for stable-ness, a stable API
needs stricter separation between the layers and more opaque pointers
etc etc.

There is a price you pay for having such a rigid scheme (it arguably has
advantages too, those are mostly relevant in a closed source system tho)
is that it's a lot harder to implement improvements. Linux isn't so much
designed as evolved, and in evolution, new dominant things emerge
regularly. A stable API would prevent those from even coming into
existing, let alone become dominant and implemented. The price linux
pays for this is that code needs changing all the time. On the other
hand.. the GPL gives you that code so that you can do that...


