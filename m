Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVASNni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVASNni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 08:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVASNng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 08:43:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30082 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261718AbVASNne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 08:43:34 -0500
Date: Wed, 19 Jan 2005 14:43:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Vincent Hanquez <tab@snarc.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/i386/kernel/signal.c: fix err test twice
Message-ID: <20050119134325.GB8112@elte.hu>
References: <20050119095913.GA4155@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119095913.GA4155@snarc.org>
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


* Vincent Hanquez <tab@snarc.org> wrote:

> Hi, the following patch:
> 	- correct the err variable tested twice when _NSIG_WORDS == 1
> 	  (unlikely to happen, but ..)

(this isnt a problem, even if it happens. But worth cleaning up
nevertheless.)

> 	- remove some |= in favor of = because we don't need to 'pack' err
> 
> Please apply,
> 
> Signed-off-by: Vincent Hanquez <tab@snarc.org>

looks good.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
