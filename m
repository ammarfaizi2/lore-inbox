Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVAGRcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVAGRcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVAGRcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:32:51 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:22404 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261363AbVAGRca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:32:30 -0500
Date: Fri, 7 Jan 2005 18:32:29 +0100
From: Martin Mares <mj@ucw.cz>
To: Chris Wright <chrisw@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107173229.GA9794@ucw.cz>
References: <20050107162902.GA7097@ucw.cz> <200501071636.j07Gateu018841@localhost.localdomain> <20050107170603.GB7672@ucw.cz> <20050107092918.B2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107092918.B2357@build.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Yes, SETPCAP became a gaping security hole.  Recall the sendmail hole.

Hmmm, I don't remember now, could you give me some pointer, please?

> This won't work, you can't increase the bset, which is hardcoded to
> leave out SETPCAP.  Also, init is hard coded to start without SETPCAP.

If I read the source correctly, init is allowed to increase the bset,
the other processes aren't.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
American patent law: two monkeys, fourteen days.
