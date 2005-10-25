Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVJYKds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVJYKds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 06:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVJYKds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 06:33:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:5592 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932121AbVJYKdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 06:33:47 -0400
Date: Tue, 25 Oct 2005 12:34:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       robustmutexes@lists.osdl.org
Subject: Re: [PATCH] 2.6.14-rc5 fails to build with out CONFIG_FUTEX
Message-ID: <20051025103400.GA30805@elte.hu>
References: <435D6F50.1000403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435D6F50.1000403@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> Both kernel/exit.c and fs/dcache.c refer to functions in 
> kernel/futex.c which is not built unless CONFIG_FUTEX is true.  This 
> causes a build failure at link time:

uhm, -rt5 you wanted to write, and a different Cc: list, right? :-)

otherwise, thanks and applied.

	Ingo
