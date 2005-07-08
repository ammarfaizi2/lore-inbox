Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVGHTio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVGHTio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVGHTfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:35:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48293 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262814AbVGHTeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:34:50 -0400
Date: Fri, 8 Jul 2005 21:34:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050708193455.GA10710@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081047.07643.s0348365@sms.ed.ac.uk> <20050708114642.GA10379@elte.hu> <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708193151.GA10210@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708193151.GA10210@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> 
> > Unfortunately I see nothing like this when the machine crashes. Find 
> > attached my config, which has CONFIG_4KSTACKS and the options you 
> > specified. Are you sure this is sufficient to enable it?
> 
> another thing - if you disable 4K stacks, which doesnt crash, and do 
> the workload that crashes 4K stacks, do you get any stack-footprint 
> maximum printouts from openvpn (or related) contexts?

and yet another guess: if this is related to interrupts then disabling 
UP_IOAPIC could change the characteristics of the crash.

	Ingo
