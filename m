Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935303AbWK2HBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935303AbWK2HBy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935313AbWK2HBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:01:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41946 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935303AbWK2HBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:01:53 -0500
Date: Wed, 29 Nov 2006 07:58:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Hu Gang <linuxbest@gmail.com>
Cc: linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.19-rc6-rt8
Message-ID: <20061129065826.GA31068@elte.hu>
References: <20061127094927.GA7339@elte.hu> <20061129091825.5438cfb9@localhost> <20061129064109.GA27932@elte.hu> <20061129144453.7cbddc75@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129144453.7cbddc75@localhost>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Hu Gang <linuxbest@gmail.com> wrote:

> > thanks, applied. I'll let the PPC -rt folks sort out the hack effects. 
> > Do you have CONFIG_HIGH_RES_TIMERS enabled?
> no.
> 
> 
> [hugang@:~]$ uname -a
> Linux hugang.soulinfo.com 2.6.19-rc6-rt8 #2 PREEMPT Wed Nov 29 09:29:43 UTC 2006 ppc GNU/Linux 
> [hugang@:~]$ zgrep CONFIG_HIGH_RES_TIMERS /proc/config.gz 
> [hugang@:~]$

could you send me your config? (i'm just curious what else is 
enabled/disabled)

	Ingo
