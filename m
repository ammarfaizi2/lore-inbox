Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTLQKfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 05:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTLQKfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 05:35:19 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30602 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264289AbTLQKfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 05:35:16 -0500
Date: Wed, 17 Dec 2003 11:35:14 +0100
From: Martin Mares <mj@ucw.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
Message-ID: <20031217103514.GA15394@atrey.karlin.mff.cuni.cz>
References: <3FDDACA9.1050600@intel.com> <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com> <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com> <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com> <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <3FDFFDEC.7090109@pobox.com> <20031217082235.GA24027@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217082235.GA24027@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> BUT powermanagement and co will need to potentially do stuff too with the
> config space...

Yes, but again they either access the registers already existing in
normal PCI where they can use the old access mechanism, or they need to
access the extended registers, but in this case it's a code specific for
PCI-X which can use different functions for that, isnt't?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If a train station is where the train stops, what is a work station?
