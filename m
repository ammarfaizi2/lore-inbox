Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVDEHPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVDEHPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVDEHOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:14:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43243 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261590AbVDEHIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:08:18 -0400
Date: Tue, 5 Apr 2005 09:07:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405070756.GA23079@elte.hu>
References: <20050405065544.GA21360@elte.hu> <20050405000319.4fa1d962.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405000319.4fa1d962.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> Do you have nmis enabled?

yeah ...

>  	call do_nmi
> -	jmp restore_all
> +	jmp restore_nocheck

and i was about to take a closer look at the NMI path :-)

	Ingo
