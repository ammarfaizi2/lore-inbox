Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbVL3IKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVL3IKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVL3IKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:10:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20907 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751214AbVL3IKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:10:16 -0500
Subject: Re: userspace breakage
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.64.0512291544310.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
	 <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
	 <20051229232548.GT3811@stusta.de>
	 <Pine.LNX.4.64.0512291544310.3298@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 09:09:59 +0100
Message-Id: <1135930199.2941.5.camel@laptopd505.fenrus.org>
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


> 
> We used to have a fairly clear point where we could break things, when we 
> had major kernel releases (ie 2.4 -> 2.6 broke the module loader. It was 
> documented, and it was unavoidable). 

maybe such a point should be added back, in the sense that the
"announced" things get batched up to, say, every 3rd kernel release.
Doing this in batches is less painful than doing it every release.


