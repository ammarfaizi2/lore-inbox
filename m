Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbUKKPOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbUKKPOj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbUKKPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:12:40 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57479 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262246AbUKKPKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:10:30 -0500
Date: Thu, 11 Nov 2004 17:12:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gunther Persoons <gunther_persoons@spymac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
Message-ID: <20041111161235.GA26582@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <41938D60.4070802@spymac.com> <20041111160819.GA26184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111160819.GA26184@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> * Gunther Persoons <gunther_persoons@spymac.com> wrote:
> 
> > Got 2 times a hard lock up with this one. Happened while i was typing
> > something and downloading both after 15-20 minutes.
> 
> .config?

just in case you are using UP-IOAPIC, could you enable CONFIG_SMP (even
if you are running an UP box) and see whether the lockup goes away? 
Which was the last -RT kernel that you tried that didnt lock up in this
fashion?

	Ingo
