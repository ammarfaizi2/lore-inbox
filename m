Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265069AbUFGVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbUFGVco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265077AbUFGVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:30:56 -0400
Received: from [213.146.154.40] ([213.146.154.40]:17880 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265069AbUFGVal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:30:41 -0400
Subject: Re: [PATCH 2.4] jffs2 aligment problems
From: David Woodhouse <dwmw2@infradead.org>
To: tglx@linutronix.de
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Greg Weeks <greg.weeks@timesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200406072256.46952.tglx@linutronix.de>
References: <40C484F9.20504@timesys.com>
	 <1086640771.29255.57.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0406071351450.1637@ppc970.osdl.org>
	 <200406072256.46952.tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jun 2004 22:29:23 +0100
Message-Id: <1086643763.29255.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 (1.5.8-3.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 22:56 +0200, Thomas Gleixner wrote:
> So we did not care if it took ms + x µs due to an alignement trap

Indeed. But since many machines I care about can't fix up unaligned
accesses I'm _more_ than happy to obey the original decree that I should
put back the get_unaligned() calls; just ignoring the stated reasons.
Let's not argue Linus out of it :)

Greg, please make sure you Cc me on flash or jffs2-related changes in
future.

-- 
dwmw2

