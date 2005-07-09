Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVGIQrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVGIQrC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVGIQrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 12:47:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:23450 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261607AbVGIQqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 12:46:55 -0400
Date: Sat, 9 Jul 2005 18:46:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: randy_dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjanv@infradead.org,
       guichaz@gmail.com
Subject: Re: [patch] compress the stack layout of do_page_fault(), x86
Message-ID: <20050709164637.GA16517@elte.hu>
References: <20050709144116.GA9444@elte.hu> <20050709152924.GA13492@elte.hu> <20050709094455.0ef508e3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709094455.0ef508e3.rdunlap@xenotime.net>
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


* randy_dunlap <rdunlap@xenotime.net> wrote:

> Just to clarify this, "boot tested" does not mean that this changed 
> code was tested, right? or do you have a test case that was tested?

i tested segfaults, but not bus-faults. The bug would have resulted in 
sigsegv being delivered not a sigbus.

	Ingo
