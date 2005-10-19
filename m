Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVJSLPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVJSLPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJSLPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:15:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:50309 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964794AbVJSLPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:15:01 -0400
Date: Wed, 19 Oct 2005 13:15:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt6, skge vs. sk98lin
Message-ID: <20051019111527.GB30185@elte.hu>
References: <1129599910.5031.3.camel@cmn3.stanford.edu> <435456A1.6020208@pobox.com> <1129600953.5031.6.camel@cmn3.stanford.edu> <20051018095028.4b78dbb2@localhost.localdomain> <Pine.LNX.4.58.0510190247340.20634@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510190247340.20634@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Like adding a spin_trylock_irqsave/spin_trylock_failed_irqrestore API?

there's spin_trylock_irqsave() already, which can be used just fine.

but in any case, this is something for the -rt tree only, with which we 
dont want to pester upstream ...

	Ingo
