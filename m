Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265681AbUGTGBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUGTGBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 02:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUGTGBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 02:01:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29675 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265681AbUGTGBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 02:01:30 -0400
Date: Tue, 20 Jul 2004 08:02:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: =?iso-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt 2.6.8-rc2-H4
Message-ID: <20040720060220.GB27118@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710075747.GA25052@elte.hu> <2a4f155d040710011041a95210@mail.gmail.com> <20040710082846.GA29275@elte.hu> <20040719103637.GA8924@elte.hu> <40FC7778.2070909@hispalinux.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40FC7778.2070909@hispalinux.es>
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


* Ramón Rey Vicente <ramon.rey@hispalinux.es> wrote:

> With 2.6.8-rc2 I get this with loop module
> 
> 	loop: Unknown symbol voluntary_resched

ok, just add this to kernel/sched.c:

	EXPORT_SYMBOL(voluntary_resched);

i'll update the patch.

	Ingo
