Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUHKGWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUHKGWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 02:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267958AbUHKGWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 02:22:20 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3203 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267957AbUHKGWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 02:22:19 -0400
Date: Wed, 11 Aug 2004 08:23:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][trivial] line up 'ESR value before/after enabling vector' messages
Message-ID: <20040811062314.GA32700@elte.hu>
References: <Pine.LNX.4.61.0408110145030.2690@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0408110145030.2690@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesper Juhl <juhl-lkml@dif.dk> wrote:

> -				" %08lx\n", value);
> +				"  %08lx\n", value);

> -		Dprintk("ESR value after enabling vector: %08x\n", value);
> +		Dprintk("ESR value after enabling vector:  %08x\n", value);

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
