Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVL3IFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVL3IFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 03:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVL3IFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 03:05:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751212AbVL3IFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 03:05:24 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <20051229231615.GV15993@alpha.home.local>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229231615.GV15993@alpha.home.local>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 09:05:17 +0100
Message-Id: <1135929917.2941.0.camel@laptopd505.fenrus.org>
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


> Can't we elect a recommended gcc version that distro makers could
> ship under the name kgcc as it has been the case for some time,

speaking as someone who used to work for a distro: this sucks for
distros. Shipping 2 compilers is NOT fun. Not fun at all! It's double
the maintenance, actually more since 1 of the 2 is only used in 1
package, so it gets a lot less testing.


