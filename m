Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVFGGTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVFGGTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 02:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVFGGTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 02:19:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29356 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261802AbVFGGTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 02:19:05 -0400
Date: Tue, 7 Jun 2005 08:18:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Voluspa <lista1@telia.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: Linux v2.6.12-rc6
Message-ID: <20050607061831.GA6957@elte.hu>
References: <20050607081116.65c10190.lista1@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607081116.65c10190.lista1@telia.com>
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


* Voluspa <lista1@telia.com> wrote:

>   CC      arch/x86_64/kernel/irq.o
>   CC      arch/x86_64/kernel/ptrace.o
> arch/x86_64/kernel/ptrace.c: In function `putreg':
> arch/x86_64/kernel/ptrace.c:285: error: duplicate case value
> arch/x86_64/kernel/ptrace.c:280: error: previously used here
> make[1]: *** [arch/x86_64/kernel/ptrace.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2

builds fine here - and i cannot see how those case values could be 
duplicate. Are you sure your build is completely clean?

	Ingo
