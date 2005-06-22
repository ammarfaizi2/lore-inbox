Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFVLaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFVLaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 07:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVFVLah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 07:30:37 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43190 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261979AbVFVLaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 07:30:23 -0400
Date: Wed, 22 Jun 2005 13:30:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: RedIpS <ris@elsat.net.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG - realtime-preempt-2.6.12-final-V0.7.50
Message-ID: <20050622113011.GA10973@elte.hu>
References: <20050622131820.4aa2554e@redips.elsat.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622131820.4aa2554e@redips.elsat.net.pl>
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


(please Cc: me on -RT bugs)

* RedIpS <ris@elsat.net.pl> wrote:

> DMESG:
> 
> nvidia: module license 'NVIDIA' taints kernel.

uh oh. Can you see this without the nvidia module loaded?

> PCI: Setting latency timer of device 0000:00:11.5 to 64
> int3: 0000 [#1]
> PREEMPT 

do you have any other patches applied ontop of -RT, like kgdb?

	Ingo
