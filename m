Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVBFSKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVBFSKu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBFSIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:08:31 -0500
Received: from canuck.infradead.org ([205.233.218.70]:50954 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261266AbVBFSIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:08:18 -0500
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
In-Reply-To: <Pine.LNX.4.58.0502061002090.2165@ppc970.osdl.org>
References: <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu>
	 <20050206125002.GF30109@wotan.suse.de>
	 <1107694800.22680.90.camel@laptopd505.fenrus.org>
	 <20050206130152.GH30109@wotan.suse.de>
	 <20050206130650.GA32015@infradead.org>
	 <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu>
	 <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu>
	 <20050206142936.GC30476@wotan.suse.de>
	 <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
	 <1107710023.22680.138.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0502060920050.2165@ppc970.osdl.org>
	 <1107711569.22680.146.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0502061002090.2165@ppc970.osdl.org>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 19:08:08 +0100
Message-Id: <1107713288.22680.153.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 10:04 -0800, Linus Torvalds wrote:
> > Ok so what to do for 2.6.11... the setarch workaround is there; that
> > works. My patch patches the worst issues and is quite minimal. What you
> > propose will be more invasive and more suitable for 2.6.11-bk1... 
> > I can do such a patch no problem (although the next two days I won't
> > have time).
> 
> Hmm.. I can take your initial patch now. Can somebody explain why this 
> hassn't come up before, though?

somehow things got "cleaned up" around 2.6.10-ish to change the
default... it's quite rare so few people noticed. It seems Andi got a
few reports in the last week or so and started investigating.




