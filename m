Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUERMkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUERMkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUERMkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:40:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:31447 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263227AbUERMkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:40:08 -0400
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
	s->tree' failed: The saga continues.)
From: Chris Mason <mason@suse.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Larry McVoy <lm@bitmover.com>, wli@holomorphy.com, hugh@veritas.com,
       adi@bitmover.com, support@bitmover.com, linux-kernel@vger.kernel.org
In-Reply-To: <200405172319.38853.elenstev@mesatop.com>
References: <200405132232.01484.elenstev@mesatop.com>
	 <200405172142.52780.elenstev@mesatop.com>
	 <Pine.LNX.4.58.0405172056480.25502@ppc970.osdl.org>
	 <200405172319.38853.elenstev@mesatop.com>
Content-Type: text/plain
Message-Id: <1084884150.20437.1391.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 May 2004 08:42:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-18 at 01:19, Steven Cole wrote:

> 2nd reply:
> I've made four successful rather large bk pulls with Chris' patch.
> Two were into two repos on my /home reiserfs, and I did
> a pull, unpull, and pull again on the new reiserfs on the second disk.
> No problems, and with PREEMPT of course.
> The last two pulls even survived a ppp failure occuring during resolve.

Good news, thank you.

> So, I take it that I should revert that one-liner if I want to get any failure data?
> With it, ext3 was pretty solid for this testing.

Yes, please test ext3 again without Andrew's one liner.

-chris


