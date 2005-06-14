Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFNTAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFNTAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 15:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFNTAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 15:00:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:64648 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261186AbVFNTA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 15:00:27 -0400
Date: Tue, 14 Jun 2005 20:54:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050614185448.GA26731@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42AF20F9.20704@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AF20F9.20704@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Ingo Molnar wrote:
> >i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
> >downloaded from the usual place:
> 
> Ingo,
> 
> I just got this soft lock with -RT-2.6.12-rc6-V0.7.48-32 on my dual 
> 2.6G Xeon W/HT. Not sure what causes it. Just typing away and its like 
> a key sticks. It keeps printing the same key, even if I use the mouse 
> to change focus the typing follows the focus, and then it finally 
> hangs.

ah ... accidentaly had debug_direct_keyboard = 1 in kernel/irq/handle.c.  
Change it to 0 & recompile, or pick up the -48-33 patch i just uploaded.

	Ingo
