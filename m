Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFFHri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFFHri (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFFHri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:47:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62420 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261192AbVFFHrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:47:36 -0400
Date: Mon, 6 Jun 2005 09:44:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, plist fixes
Message-ID: <20050606074458.GA11875@elte.hu>
References: <20050605082616.GA26824@elte.hu> <Pine.LNX.4.44.0506050830050.23583-100000@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0506050830050.23583-100000@dhcp153.mvista.com>
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

> 	For me it's strictly a speed question. I was reviewing 
> V0.7.40-04 and it looks like apples and oranges to me. It's more a 
> question of where do you perfer the latency , in up() or in down() .. 
> plist is slower for non-RT tasks, but non-RT tasks also get the 
> benefit of priority ordering.

what benefit do non-RT tasks get from plists, compared to the ordered 
list? Non-RT tasks are not PI handled in any way.

	Ingo
