Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVL2HtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVL2HtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 02:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVL2HtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 02:49:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20651 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932577AbVL2HtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 02:49:09 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
In-Reply-To: <20051228201150.b6cfca14.akpm@osdl.org>
References: <20051228114637.GA3003@elte.hu>
	 <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	 <1135798495.2935.29.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
	 <20051228201150.b6cfca14.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 08:49:04 +0100
Message-Id: <1135842544.2935.0.camel@laptopd505.fenrus.org>
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


> IOW: I'd prefer that we be the ones who specify which functions are going
> to be inlined and which ones are not.

a bold statement... especially since the "and which ones are not" isn't
currently there, we still leave gcc a lot of freedom there ... but only
in one direction.

