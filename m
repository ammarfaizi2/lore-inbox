Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUK2Tdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUK2Tdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbUK2Tdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:33:36 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:47572 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261581AbUK2TA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:00:28 -0500
Message-ID: <41AB71B2.1050301@colorfullife.com>
Date: Mon, 29 Nov 2004 20:00:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Nesterov <oleg@tv-sign.ru>
CC: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: eliminate rcu_data.last_qsctr
References: <41AA0D5F.21CB9ED3@tv-sign.ru>
In-Reply-To: <41AA0D5F.21CB9ED3@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:

>last_qsctr is used in rcu_check_quiescent_state() exclusively.
>We can reset qsctr at the start of the grace period, and then
>just test qsctr against 0.
>
>On top of the 'rcu: eliminate rcu_ctrlblk.lock', see
>http://marc.theaimsgroup.com/?l=linux-kernel&m=110156786721526
>
>Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>
>  
>
Compile and boot tested with 2.6.10-rc2 on a 2-cpu system.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

