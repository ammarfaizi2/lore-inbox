Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270775AbRHNTyo>; Tue, 14 Aug 2001 15:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270759AbRHNTyY>; Tue, 14 Aug 2001 15:54:24 -0400
Received: from shad0w.dial.nildram.co.uk ([195.112.18.51]:47369 "EHLO
	mail.shad0w.org.uk") by vger.kernel.org with ESMTP
	id <S270780AbRHNTyS>; Tue, 14 Aug 2001 15:54:18 -0400
Date: Tue, 14 Aug 2001 20:56:55 +0100 (BST)
From: Chris Crowther <chrisc@shad0w.org.uk>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CDP handler for linux
In-Reply-To: <200108141930.f7EJUNj01929@ns.caldera.de>
Message-ID: <Pine.LNX.4.33.0108142050550.3683-100000@monolith.shad0w.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Christoph Hellwig wrote:

> > +export-objs = af_cdp.o
>
> You don't export symbols, so you don't need to add your object to export-objs.

	Now removed :)

> > +		tar -cvf /dev/f1 .
>
> Kill this tar rule, please :)

	Ditto.

> > + *	Portions Copyright (c) 2001 Chris Crowther.
>
> I think it's all yours, isn't it?

	I was playing safe as usual - I'm not entirely sure on the
copyright of the CDP definition - it's created by Cisco so it's their
property - but there's a published break down of how it's built so I'm not
sure how things work re: implementing it on other systems.

> Besides this little nitpicks I'd like to give you the advise to send this
> to linuxnetdev, too.

	ok, will do - just as soon as I find the addy :)

-- 
Chris "_Shad0w_" Crowther
shad0w@shad0w.org.uk
http://www.shad0w.org.uk/

