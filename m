Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVAGRGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVAGRGG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVAGRGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:06:06 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:12676 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261310AbVAGRGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:06:02 -0500
Date: Fri, 7 Jan 2005 18:06:03 +0100
From: Martin Mares <mj@ucw.cz>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107170603.GB7672@ucw.cz>
References: <20050107162902.GA7097@ucw.cz> <200501071636.j07Gateu018841@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071636.j07Gateu018841@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> They are present but disabled by default. You have to hack the initial
> values of CAP_INIT_EFF_SET and CAP_INIT_IHN_SET.

Oops. Does anybody know why this has been done?

Also, it seems that it has a relatively easy work-around: boot with
init=/sbin/simple-wrapper and let the wrapper set the cap_bset and exec real
init. (I agree that it's a hack, but a temporarily usable one.)

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"When I was a boy I was told that anybody could become President; I'm beginning to believe it." -- C. Darrow
