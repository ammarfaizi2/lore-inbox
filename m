Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVAICRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVAICRu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 21:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAICRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 21:17:50 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:16654 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262240AbVAICRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 21:17:48 -0500
Date: Sun, 9 Jan 2005 03:17:43 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andries Brouwer <aebr@win.tue.nl>, Andreas Schwab <schwab@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050109021743.GG6052@pclin040.win.tue.nl>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <je8y73zl35.fsf@sykes.suse.de> <20050109004949.GF6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501090320210.4014@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501090320210.4014@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 03:21:22AM +0100, Jesper Juhl wrote:

> >        Later code tries to prefix these  names  with  "/usr/lib",
> >        "/lib" and "" before giving up.  In libc 4.4.1 these names
> 
> Don't you mean 
> 	"/lib" and "/" before giving up. 

No.

(But I should have added a reference to dlopen(3).)

Note that not only a.out but also ELF binaries are loaded by uselib.

Andries
