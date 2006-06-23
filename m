Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWFWN6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFWN6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWFWN55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:57:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:7128 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750713AbWFWNm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:42:57 -0400
Date: Fri, 23 Jun 2006 15:38:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 1/4] lock validator: provide common print_ip_sym()
Message-ID: <20060623133801.GB15113@elte.hu>
References: <20060623132355.GE9446@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623132355.GE9446@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Provide a common print_ip_sym() function that prints the passed instruction
> pointer as well as the symbol belonging to it. Avoids adding a bunch of
> #ifdef CONFIG_64BIT in order to get the printk format right on 32/64 bit
> platforms.
> 
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
