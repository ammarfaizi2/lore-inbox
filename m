Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUGWFao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUGWFao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 01:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267547AbUGWFao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 01:30:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3991 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262138AbUGWFan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 01:30:43 -0400
Date: Fri, 23 Jul 2004 07:31:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] consolidate sched domains
Message-ID: <20040723053150.GA13215@elte.hu>
References: <41008386.9060009@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41008386.9060009@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> The attached patch is against 2.6.8-rc1-mm1. Tested on SMP, UP and
> SMP+HT here and it seems to be OK.

looks good to me. I certainly like this property:

 12 files changed, 179 insertions(+), 619 deletions(-)

	Ingo
