Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWJEICO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWJEICO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWJEICO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:02:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:40166 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751203AbWJEICL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:02:11 -0400
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
	passing to IRQ handlers
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <20061002132116.2663d7a3.akpm@osdl.org> <20061002201836.GB31365@elte.hu>
	 <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 09:01:55 +0100
Message-Id: <1160035315.26064.20.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 13:54 -0700, Linus Torvalds wrote:
> Yeah, well, it's been discussed before, and the real problem is not the 
> patch itself, it's the damn drivers maintained outside the tree, and 
> people who want to maintain the same driver for multiple different 
> versions of the kernel.

Maintaining drivers out of tree is shameless autoflagellation at the
best of times. We really don't care -- if we didn't make life hard for
them in this way they'd only go and stick pins under their fingernails
to make up for the lack of pain. If you think about it like that, we're
probably doing them a favour -- at least this way they're _safe_.

> So if the patch works against my current tree, and nobody objects, I can 
> certainly apply it.
> 
> So speak up, people...

Go for it.

-- 
dwmw2

