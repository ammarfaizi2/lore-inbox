Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVKLPcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVKLPcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVKLPci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:32:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8064 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932397AbVKLPch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:32:37 -0500
Date: Sat, 12 Nov 2005 16:32:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Felix Oxley <lkml@oxley.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: [ANNOUNCE] 2.6.14-rc5-rt5 kgdb update
Message-ID: <20051112153239.GA27824@elte.hu>
References: <20051017160536.GA2107@elte.hu> <200510211118.18363.lkml@oxley.org> <200510211126.38200.lkml@oxley.org> <200510230023.41494.lkml@oxley.org> <435D6017.8090001@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435D6017.8090001@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> For those using kgdb on the rt kernel, I have just updated the patches at:
> http://source.mvista.com/~ganzinger/

i tried your kgdb-ga-rt.patch patch on the -rt tree, and it doesnt seem 
to work: i get up to the initial breakpoint, but after the 'cont' the 
target system hangs indefinitely. Does it work for you? Config attached.

	Ingo
