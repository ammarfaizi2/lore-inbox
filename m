Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVAGQ3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVAGQ3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVAGQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:29:10 -0500
Received: from albireo.ucw.cz ([81.27.203.89]:60547 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S261494AbVAGQ3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:29:01 -0500
Date: Fri, 7 Jan 2005 17:29:02 +0100
From: Martin Mares <mj@ucw.cz>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Jack O'Quin" <joq@io.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050107162902.GA7097@ucw.cz>
References: <20050107160808.GB6529@ucw.cz> <200501071614.j07GEgEC018705@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501071614.j07GEgEC018705@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> i think this is true only if the kernel comes with capabilities
> enabled.
> 
> various media-centric distributions (CCRMA, demudi, dyne:bolic and
> others) enabled them for their 2.4 kernels, but not the major
> desktop-centric ones. then the impression began to be received that in
> 2.6, capabilities were even more questionable of a mechanism to use.
> In addition, the LSM system appeared, and seemed to offer a much
> better solution entirely: no need to patch the kernel at all, or at
> least it appeared to be so in the beginning. Hence the "realtime" LSM.

Yes, but is there really some difference between people having to enable
LSM and add a new LSM module, and people recompiling the kernel to include
capabilities?

Also, is somebody really shipping 2.4 kernels without capabilities?
I'm unable to find any such config switch in 2.4.28 -- maybe it's because
I'm almost sleeping now, but it doesn't seem to be there.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
return(ECRAY); /* Program exited before being run */
