Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267809AbRGWD2M>; Sun, 22 Jul 2001 23:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbRGWD2C>; Sun, 22 Jul 2001 23:28:02 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:38664 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S267809AbRGWD1x>;
	Sun, 22 Jul 2001 23:27:53 -0400
Message-Id: <200107230202.f6N228NG016619@sleipnir.valparaiso.cl>
To: landley@webofficenow.com
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch 
In-Reply-To: Message from Rob Landley <landley@webofficenow.com> 
   of "Sun, 22 Jul 2001 11:15:07 -0400." <01072211150706.08013@localhost.localdomain> 
Date: Sun, 22 Jul 2001 22:02:07 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rob Landley <landley@webofficenow.com> said:
> On Thursday 19 July 2001 14:24, Pavel Machek wrote:

[...]

> > > No, if the file was removed, it still tells you where to start your
> > > search.  A missing filename is just as good a marker as a present one.

> > And if new file is created with same name?

> The same thing that happens as if a new file was inserted BEFORE your
> cursor, in the part of the directory you've already looked at.  You
> ignore it.

Who says that if I've got files A, B, C, D, and delete B, and create a new
B, whatever underlying directory structure there is will place it where the
old B was? It might reuse holes before A...
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
