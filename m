Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVGKOQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVGKOQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVGKOOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:14:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:16516 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261744AbVGKOMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 10:12:54 -0400
Date: Mon, 11 Jul 2005 16:12:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050711141232.GA16586@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050709155704.GA14535@elte.hu> <200507091704.12368.s0348365@sms.ed.ac.uk> <200507111455.45105.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507111455.45105.s0348365@sms.ed.ac.uk>
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


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> Here's a screenshot of the oops. Notice that "stack left" is now -52. 
> We've confirmed this is a stack overflow!
> 
> http://devzero.co.uk/~alistair/oops8.jpeg
> 
> I'm going to try the 8K stack kernel with the same stuff and see if I 
> can get a stack trace. I hope this is the beginning of the end for 
> this problem.

might be an incorrect printout of stack_left :( The esp looks more or 
less normal. Not sure why it printed -52.

	Ingo
