Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966923AbWKUIX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966923AbWKUIX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966925AbWKUIX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:23:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5541 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966923AbWKUIX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:23:57 -0500
Date: Tue, 21 Nov 2006 09:22:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.19-rc6-rt0, -rt YUM repository
Message-ID: <20061121082249.GA2433@elte.hu>
References: <20061116153553.GA12583@elte.hu> <1163694712.26026.1.camel@localhost.localdomain> <Pine.LNX.4.64.0611162212110.21141@frodo.shire> <1163713469.26026.4.camel@localhost.localdomain> <20061116220733.GA17217@elte.hu> <1163779116.6953.38.camel@mindpipe> <20061117161742.GA10182@elte.hu> <1163785495.3097.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163785495.3097.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0221]
	0.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> [...] are you just grabbing Jeff's tree? I noticed they aren't always 
> commented "shut up gcc" .

> -       } prev, curr;
> +       } prev = { } /* shut up gcc */ , curr = { } /* shut up gcc */ ;

i just do them by hand every time i hit one.

	Ingo
