Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVEIODL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVEIODL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 10:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVEIODL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 10:03:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:47745 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261373AbVEIODI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 10:03:08 -0400
Date: Mon, 9 May 2005 16:02:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: Real-Time Preemption: Magic Sysrq p doesn't work
Message-ID: <20050509140257.GA4714@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323204@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323204@MAILIT.keba.co.at>
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


* kus Kusche Klaus <kus@keba.com> wrote:

> I've been asked to analyze the various tools and possibilities 
> available to debug an RT kernel.
> 
> Up to now, what I've found is not too impressive:
> * Plain GDB can be used to display the current value of kernel variables
> symbolically, but no more: It won't tell anything about the kernel's
> current activity.
> * kgdb and kdb seem to be deeply incompatible with the RT patches (they
> mess with the scheduler, interrupts etc.), applying their patches to an
> RT tree fails quite impressively.

kgdb is in the -mm tree, and there are periodic ports to the -mm tree. 
Someone used it too on PREEMPT_RT - with some success. There's no deep 
incompatibility with the -RT kernel - just line-for-line collisions.

	Ingo
