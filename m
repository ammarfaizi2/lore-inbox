Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVIAHJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVIAHJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVIAHJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:09:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:34270 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932545AbVIAHJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:09:37 -0400
Date: Thu, 1 Sep 2005 09:10:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: PREEMPT_RT with e1000
Message-ID: <20050901071008.GD5179@elte.hu>
References: <1125518602.15034.3.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125518602.15034.3.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> It looks like Gigabit Ethernet is still having some problems. This is 
> with the e1000 driver. If I remove all the qdisc_restart changes it 
> starts to work the warning below goes away, but it has 
> smp_processor_id warnings.

btw., what does "problems" mean, precisely - does it not work at all, or 
does it produce the lockup under certain loads?

	Ingo
