Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbRFQV0K>; Sun, 17 Jun 2001 17:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbRFQV0A>; Sun, 17 Jun 2001 17:26:00 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:63247 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S262915AbRFQVZr>; Sun, 17 Jun 2001 17:25:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Newbie idiotic questions.
Date: Sun, 17 Jun 2001 23:28:34 +0200
X-Mailer: KMail [version 1.2]
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Flynn <Dave@keston.u-net.com>, rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0106171628350.15952-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0106171628350.15952-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <0106172328340U.00879@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 June 2001 22:37, Alexander Viro wrote:
> On Sun, 17 Jun 2001, Daniel Phillips wrote:
> > Well, since we are still beating this one to death, I'd written a "knew"
> > macro as well, and put it aside.  It does the assignment for you too:
> >
> >    #define knew(p) ((p) = (typeof(p)) kmalloc(sizeof(*(p)), GFP_KERNEL))
> >
> > Terse and clear at the same time, and type safe.  I still don't like it
> > much.
>
> And ungreppable, not to mention gratitious use of GNU extension.

typeof?  It's rather popular in the kernel already.  Besides, who is going to 
compile this with anything other than gcc?

I don't see your point about greppability.

--
Daniel
