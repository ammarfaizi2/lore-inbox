Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbUL3QTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUL3QTv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 11:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbUL3QTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 11:19:51 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:53658 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261664AbUL3QTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 11:19:49 -0500
Message-ID: <41D4395F.2B31602D@tv-sign.ru>
Date: Thu, 30 Dec 2004 20:22:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: speed up quiescent state detection
References: <41D429C5.F32D7161@tv-sign.ru> <41D42096.3020708@colorfullife.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> one timer tick, without changing the approach. I'm still thinking about
> the design change I proposed: In each quiescent state: check if there is
> a running grace period and if there is one, then mark the current cpu as
> done.
> 

I must admit, i have misunderstood your patch after the first reading.
Now i think your idea is better.

Oleg.
