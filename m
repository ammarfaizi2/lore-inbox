Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVDEHRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVDEHRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDEHRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:17:00 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33441 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261590AbVDEHQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:16:20 -0400
Date: Tue, 5 Apr 2005 09:16:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stsp@aknet.ru
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
Message-ID: <20050405071604.GA23355@elte.hu>
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

> From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
> 
> With nmi_watchdog=1, I got random Oopses (Unable to handle kernel 
> paging request, not by the NMI oopser) from many processes.  It is not 
> happend with -rc1.
> 
> The following change fixes this problem.

this fixed my crashes too.

	Ingo
