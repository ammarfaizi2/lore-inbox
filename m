Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUIHJy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUIHJy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269081AbUIHJy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:54:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:3482 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269080AbUIHJy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:54:56 -0400
Date: Wed, 8 Sep 2004 11:56:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Alexander Nyberg <alexn@dsv.su.se>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R9
Message-ID: <20040908095630.GA4709@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <1094597988.16954.212.camel@krustophenia.net> <20040908082050.GA680@elte.hu> <200409081146.09526.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409081146.09526.rjw@sisk.pl>
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


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> Er, it doesn't work for me:
> 
>   HOSTCC  scripts/genksyms/parse.o
>   HOSTLD  scripts/genksyms/genksyms
>   CC      scripts/mod/empty.o
> /bin/sh: line 1: x86_64-unknown-linux-gcc: command not found
> make[2]: *** [scripts/mod/empty.o] Error 127
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2

please re-download -R9, it had my crosscompiler flags included by
accident.

	Ingo
