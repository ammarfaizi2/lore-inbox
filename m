Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSIKKpX>; Wed, 11 Sep 2002 06:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSIKKpX>; Wed, 11 Sep 2002 06:45:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:45222 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318691AbSIKKpW>; Wed, 11 Sep 2002 06:45:22 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 11 Sep 2002 12:51:31 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ignore pci devices?
Message-ID: <20020911105131.GB5955@bytesex.org>
References: <20020910134708.GA7836@bytesex.org> <1031668032.31549.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031668032.31549.60.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > can't identify and blacklist it easily.  Thus I need some way to allow
> > the users to tell bttv (or the kernel) to ignore that particular PCI
> > card.
> 
> Doh.. If the vendor isnt setting subsystem ids then its not valid
> hardware for windows nowdays. Obvious question - what else is on that
> board that might let you do the idents.

Well, at least nothing in PCI space.  It looks just like a random,
cheap bt878 card.

> We already find the USB on the NSC SuperIO by peeking at the next
> device along and checking if its the SuperIO functions 8)

It is a PCI card you can plug into some slot, not a motherboard ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
