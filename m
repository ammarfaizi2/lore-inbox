Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVFEJkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVFEJkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 05:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVFEJkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 05:40:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18321 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261539AbVFEJkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 05:40:43 -0400
Date: Sun, 5 Jun 2005 11:36:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RT and pi_test
Message-ID: <20050605093632.GA6283@elte.hu>
References: <Pine.LNX.4.44.0506010706000.23057-100000@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0506010706000.23057-100000@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> 	I've run the pi_test a few times recently with some strange 
> numbers. I'm getting abnormally high task latency if I run "./test 
> --tasks=10 ./hist" . Depending on how long I run it, I've seen task 
> latency as high as 3 milliseconds, should be 0.1ms or less.
> 
> The first time I saw these latencies I has the PI abstraction applied, 
> and the most recent time I had the attached patch applied only. This 
> patch is small so I'm not sure if it could have that type of effect on 
> task latency.

this patch now clashes with Thomas' changes. Did you mean me to apply 
this patch, or is it now moot? (The way i read your mail originally what 
that it was describing a problem with latencies, and including a patch 
as the only thing that you had applied. It didnt too inviting to apply
:-| )

	Ingo
