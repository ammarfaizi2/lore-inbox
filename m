Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUI2Bta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUI2Bta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUI2Bta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:49:30 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:63711 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268147AbUI2Bt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:49:28 -0400
Date: Wed, 29 Sep 2004 03:48:10 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stefan Seyfried <seife@suse.de>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Chris Wright <chrisw@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
Message-ID: <20040929014810.GI4084@dualathlon.random>
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random> <1096291898.9911.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096291898.9911.25.camel@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 02:31:39PM +0100, Alan Cox wrote:
> On Llu, 2004-09-27 at 15:16, Andrea Arcangeli wrote:
> > because I never use suspend/resume on my desktop, I never shutdown my
> > desktop. I don't see why should I spend time typing a password when
> > there's no need to. Every single guy out there will complain at linux
> > hanging during boot asking for password before reaching kdm.
> 
> So attempt a decrypt with a null password before asking. 

Not sure to understand, sorry. I was talking about the cryptoswap above.
there's no reason to type a password from userspace as far as cryptoswap
is concerned, nor to attempt a decrypt. A long random key choosen by the
kernel is more secure, that will be a single key used for both encrypt
and decrypt, and it'll always work.
