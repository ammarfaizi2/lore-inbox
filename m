Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161220AbWHAGwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWHAGwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWHAGwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:52:07 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:53133 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1161220AbWHAGwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:52:05 -0400
Date: Tue, 1 Aug 2006 08:17:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Nikita Danilov <nikita@clusterfs.com>,
       Joe Perches <joe@perches.com>, Martin Waitz <tali@admingilde.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial
 step
In-Reply-To: <m3wt9vj94n.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0608010816290.10130@yvahk01.tjqt.qr>
References: <200607301830.01659.jesper.juhl@gmail.com> <m3ac6rkp8c.fsf@defiant.localdomain>
 <9a8748490607301014rf04b6cew9d991635a7834277@mail.gmail.com>
 <m3wt9vj94n.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think it's a good thing that we have to take a little more care when
>> choosing global function and variable names... Take up() for example -
>> in my (very humble) oppinion that is a very bad name for a global
>> function - it clashes too easily with local function and variable
>> names, and a programmer who's not careful may end up calling the
>> global up() when he wants the local and vice versa (a much better name
>> would have been sem_up() - should we change that???).
>
>(authors of (yet) off-tree things would hate us)

Mark up() as deprecated while sem_up() emerges - hey, we even have an
__attribute__(()) for that..


Jan Engelhardt
-- 
