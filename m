Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVEVL7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVEVL7u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 07:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEVL7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 07:59:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49879 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261791AbVEVL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 07:59:45 -0400
Subject: Re: When we detect that a 16550 was in fact part of a NatSemi
	SuperIO chip
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rmk@arm.linux.org.uk, torvalds@osdl.org
In-Reply-To: <200505220008.j4M08uE9025378@hera.kernel.org>
References: <200505220008.j4M08uE9025378@hera.kernel.org>
Content-Type: text/plain
Date: Sun, 22 May 2005 12:57:13 +0100
Message-Id: <1116763033.19183.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-21 at 17:08 -0700, Linux Kernel Mailing List wrote:
> author David Woodhouse <dwmw2@org.rmk.(none)> Sat, 21 May 2005 15:52:23 +0100
> committer Russell King <rmk+kernel@arm.linux.org.uk> Sat, 21 May 2005 15:52:23 +0100
> 
> When we detect that a 16550 was in fact part of a NatSemi SuperIO chip
> with high-speed mode enabled, we switch it to high-speed mode so that
> baud_base becomes 921600. However, we also need to multiply the baud
> divisor by 8 at the same time, in case it's already in use as a console.
> 
> Signed-off-by: David Woodhouse
> Acked-by: Tom Rini
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Linus, please do not apply patches from me which have my personal
information mangled or removed. I object to having my contributions
anonymised in this way, just as I object to the contributions of others
being anonymised. This makes it harder to contact those responsible for
changes which are committed via Russell's trees, and makes a nonsense of
the practice of including Signed-off-by: lines from the contributor.

If Russell thinks that he's bound by the UK's Data Protection Act, then
he presumably thinks that he's also obliged to honour my demand that he
correct my personal information in his 'database'. His nonsensical
amateur interpretation of the law would put him in a Catch-22 situation.

-- 
dwmw2

