Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262113AbVCNLCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262113AbVCNLCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVCNLCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:02:00 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:23987 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262113AbVCNLBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:01:52 -0500
Message-ID: <42356F19.7060307@yahoo.com.au>
Date: Mon, 14 Mar 2005 22:01:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com> <20050311203427.052f2b1b.akpm@osdl.org> <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com> <20050314070230.GA24860@elte.hu> <42354562.1080900@yahoo.com.au> <20050314081402.GA26589@elte.hu> <42354A3F.4030904@yahoo.com.au> <1110789270.6288.53.camel@laptopd505.fenrus.org> <20050314104611.GA30392@elte.hu>
In-Reply-To: <20050314104611.GA30392@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> 
>>as I said, since the cacheline just got dirtied, the write is just
>>half a cycle which is so much in the noise that it really doesn't
>>matter.
> 
> 
> ok - the patch below is a small modification of Hugh's so that we clear
> ->break_lock unconditionally. Since this code is not inlined it ought to
> have minimal icache impact too.
> 

Fine by me.

