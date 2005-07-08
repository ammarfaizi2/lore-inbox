Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVGHUXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVGHUXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262833AbVGHTtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:49:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34982 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262835AbVGHTtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:49:01 -0400
Date: Fri, 8 Jul 2005 21:48:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050708194827.GA22536@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081047.07643.s0348365@sms.ed.ac.uk> <20050708114642.GA10379@elte.hu> <200507081938.27815.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507081938.27815.s0348365@sms.ed.ac.uk>
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

> Unfortunately I see nothing like this when the machine crashes. Find 
> attached my config, which has CONFIG_4KSTACKS and the options you 
> specified. Are you sure this is sufficient to enable it?

i have booted your .config, and stack overflow debugging is active and 
working. So it probably wasnt a straight (detectable) stack recursion / 
stack footprint issue.

	Ingo
