Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263278AbVBDK3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263278AbVBDK3M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263556AbVBDK27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:28:59 -0500
Received: from web51608.mail.yahoo.com ([206.190.38.213]:39099 "HELO
	web51608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263424AbVBDK0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:26:38 -0500
Message-ID: <20050204102637.94143.qmail@web51608.mail.yahoo.com>
Date: Fri, 4 Feb 2005 11:26:37 +0100 (CET)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: Re: 2.6.10: kswapd spins like crazy
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Cc: terje_fb@yahoo.no, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <4202CDBF.9070304@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> skrev: 

> No none yet, which is what we should get to the
> bottom of. I must be overlooking something, but the
> only ways I can see should be due to transient 
> conditions like page locked or under writeback. 
> laptop_mode?
> 
> Terje, what is /proc/sys/vm/laptop_mode set to?

0. I didn't touch any vm-specific options at all.

I just rebooted with your patch. I can _not_ reproduce
the problem until now. So far so good. But yesterday I
couldn't reproduce it straightaway either. 

I'll continue to do the same things I did yesterday
before kswapd started to spin. 

Regards,
Terje

