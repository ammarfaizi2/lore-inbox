Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVGLNyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGLNyc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVGLNy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:54:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31677 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261337AbVGLNyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:54:08 -0400
Date: Tue, 12 Jul 2005 15:53:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050712135325.GA18296@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu> <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu> <20050709130557.GA5763@elte.hu> <Pine.LNX.4.58.0507111359400.13011@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507111359400.13011@echo.lysdexia.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Weston <weston@sysex.net> wrote:

> On Sat, 9 Jul 2005, Ingo Molnar wrote:
> 
> > this patch reduces ip_setsockopt's stack footprint from 572 bytes to 164 
> > bytes. (Note: needs review and testing as i could not excercise this 
> > multicast codepath.)
> 
> This patch breaks multicast source group joins.  Here's the fix:

ouch - indeed, thanks.

	Ingo
