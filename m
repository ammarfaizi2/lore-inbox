Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbUKKUm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbUKKUm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbUKKUkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 15:40:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38798 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262355AbUKKUjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 15:39:05 -0500
Date: Thu, 11 Nov 2004 22:41:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Remi Colinet <remi.colinet@free.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-0
Message-ID: <20041111214102.GB5453@elte.hu>
References: <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <4193D21A.7010809@free.fr> <4193B2A3.8020103@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4193B2A3.8020103@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> +#ifdef RTC_IRQ
>  	rtc_open_event();
> +#endif

> +#ifdef RTC_IRQ
>  	rtc_close_event();
> +#endif

indeed. I fixed it a bit differently in my tree, will upload a new patch
soon.

	Ingo
