Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbUKDOFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUKDOFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUKDOFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:05:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48816 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262224AbUKDOFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:05:25 -0500
Date: Thu, 4 Nov 2004 15:05:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Michael J. Cohen" <mjc@unre.st>
Cc: "K.R. Foley" <kr@cybsft.com>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Message-ID: <20041104140528.GA16604@elte.hu>
References: <4189108C.2050804@blueyonder.co.uk> <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk> <418988A6.4090902@cybsft.com> <20041104100634.GA29785@elte.hu> <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost> <20041104114545.GA3722@elte.hu> <1099573171.7876.0.camel@optie.uni.325i.org> <1099575262.8110.1.camel@optie.uni.325i.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099575262.8110.1.camel@optie.uni.325i.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael J. Cohen <mjc@unre.st> wrote:

> I just managed to hardlock it reproducibly with no useful output on
> serial.

do you have APIC+IOAPIC enabled & nmi_watchdog=1?

if you have KGDB enabled then i'd suggest to disable it, it's totally
untested on PREEMPT_REALTIME.

	Ingo
