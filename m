Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWIKHqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWIKHqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWIKHqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:46:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9614 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751192AbWIKHqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:46:19 -0400
Date: Mon, 11 Sep 2006 09:38:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060911073809.GB3188@elte.hu>
References: <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu> <45051330.5050205@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45051330.5050205@goop.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4917]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., what's the connection of %gs based PDA to Xen and 
paravirtualization in general - %esp based current is just as 
Xen-friendly, or am i wrong? I guess there must be some connection, 
given that you are working on this ;)

	Ingo
