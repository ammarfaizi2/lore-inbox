Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVLTIG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVLTIG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVLTIG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:06:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24276 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750833AbVLTIG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:06:58 -0500
Subject: Re: [patch 00/15] Generic Mutex Subsystem
From: Arjan van de Ven <arjan@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Benjamin LaHaise <bcrl@kvack.org>
In-Reply-To: <43A7BAB5.7020201@yahoo.com.au>
References: <20051219013415.GA27658@elte.hu>
	 <20051219042248.GG23384@wotan.suse.de>
	 <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>
	 <20051219155010.GA7790@elte.hu>
	 <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org>
	 <20051219195553.GA14155@elte.hu>
	 <Pine.LNX.4.64.0512191203120.4827@g5.osdl.org>
	 <43A7BAB5.7020201@yahoo.com.au>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 09:06:47 +0100
Message-Id: <1135066007.2952.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Then code can switch to "struct mutex" if people want to. And if one 
> > reason for it ends up being that the code avoids a performance bug in the 
> > process, all the better ;)
> > 
> 
> Is this a good idea? Then we will have for a long time different
> bits of code with exactly the same synchronisation requirements
> using two different constructs that are slightly different. Not to
> mention code specifically requiring semaphores would get confusing.
> 
> If we agree mutex is a good idea at all (and I think it is), then
> wouldn't it be better to aim for a wholesale conversion rather than
> "if people want to"?

well most of this will "only" take a few kernel releases ;-)


