Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTLTLqH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 06:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTLTLqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 06:46:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:31363 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263921AbTLTLqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 06:46:06 -0500
Date: Sat, 20 Dec 2003 12:45:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched domains w27 for 2.6.0
Message-ID: <20031220114508.GA19417@elte.hu>
References: <3FE31212.3020701@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE31212.3020701@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <piggin@cyberone.com.au> wrote:

> http://www.kerneltrap.org/~npiggin/w27/
> 
> This patch includes a lot of fixes, especially to the active balancing
> and HT code. It also addresses Rusty's suggestions, and will hopefully
> fix Zwane's interactivity problems. Testing, comments welcome.

it's looking good so far - this was my final major conceptual peevee. 
Active balancing is a pretty essential feature - i'm glad you carried
the concept over from my HT patch. It increases complexity, but it's
worth it.

	Ingo
