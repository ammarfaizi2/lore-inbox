Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTIWNhI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTIWNhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:37:07 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:27567 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261298AbTIWNhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:37:05 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm4: wanxl doesn't compile with gcc 2.95
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	<20030922191049.GC6325@fs.tum.de> <m3fzioigxw.fsf@defiant.pm.waw.pl>
	<20030922154132.2d134e6f.akpm@osdl.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 23 Sep 2003 15:24:30 +0200
In-Reply-To: <20030922154132.2d134e6f.akpm@osdl.org>
Message-ID: <m3smmnprht.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> > +		       " at 0x%LX!\n", card_name(pdev), (u64)addr);
> 
> This should be "unsigned long long", not u64.  That is what "%L" means,
> after all.

Right. I was under an impression they're the same.

I assume you don't want (me to post) a corrected patch, do you?

Thanks.
-- 
Krzysztof Halasa, B*FH
