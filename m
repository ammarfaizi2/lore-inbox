Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVEYN6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVEYN6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVEYN6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:58:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45225 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262303AbVEYN6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:58:49 -0400
Date: Wed, 25 May 2005 15:58:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
Message-ID: <20050525135828.GB29078@elte.hu>
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu> <4293420C.8080400@yahoo.com.au> <20050524150537.GA11829@elte.hu> <42934748.8020501@yahoo.com.au> <20050524152759.GA15411@elte.hu> <20050524154230.GA17814@elte.hu> <20050525052400.46bccf26.akpm@osdl.org> <20050525135130.GA27088@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525135130.GA27088@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> The patch below should address this problem for all architectures, by 
> doing an explicit schedule() in the init code before calling into 
> cpu_idle(). It's a replacement for the following patch:
> 
>  sched-remove-set_tsk_need_resched-from-init_idle.patch

builds/boots fine on x86.

	Ingo
