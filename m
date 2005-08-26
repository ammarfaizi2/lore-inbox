Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbVHZGRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbVHZGRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVHZGRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:17:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:38359 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932523AbVHZGRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:17:13 -0400
Date: Fri, 26 Aug 2005 08:17:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc7-rt1
Message-ID: <20050826061758.GC17783@elte.hu>
References: <20050825062651.GA26781@elte.hu> <1125012596.14592.12.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125012596.14592.12.camel@dhcp153.mvista.com>
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

> Devastating latency on a 3Ghz xeon .. Maybe the raw_spinlock in the 
> timer base is creating a unbounded latency?

could you please submit a more complete bugreport? What did you do that 
triggered this? Kernel config would be nice too, and a latency_trace.

	Ingo
