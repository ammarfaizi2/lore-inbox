Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVAICKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVAICKE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 21:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVAICKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 21:10:04 -0500
Received: from mail.dif.dk ([193.138.115.101]:41600 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262224AbVAICJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 21:09:51 -0500
Date: Sun, 9 Jan 2005 03:21:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andreas Schwab <schwab@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
In-Reply-To: <20050109004949.GF6052@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.61.0501090320210.4014@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>
 <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain>
 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet>
 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <je8y73zl35.fsf@sykes.suse.de>
 <20050109004949.GF6052@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Andries Brouwer wrote:

> On Sat, Jan 08, 2005 at 10:07:10PM +0100, Andreas Schwab wrote:
> > Linus Torvalds <torvalds@osdl.org> writes:
> > 
> > > Another issue is likely that we should make the whole "uselib()"
> > > interfaces configurable. I don't think modern binaries use it (where
> > > "modern" probably means "compiled within the last 8 years" ;).
> > 
> > I don't think it was ever being used for anything besides a.out so IMHO it
> > should depend on BINFMT_AOUT.
> 
> Let me contribute a man page. Comments welcome (-> aeb@cwi.nl).
> 
> USELIB(2)           Linux Programmer's Manual           USELIB(2)
> 
[...]
> 
>        Later code tries to prefix these  names  with  "/usr/lib",
>        "/lib" and "" before giving up.  In libc 4.4.1 these names

Don't you mean 
	"/lib" and "/" before giving up. 

??


-- 
Jesper Juhl


