Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVDUH0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDUH0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDUH0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:26:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30648 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261429AbVDUH0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:26:45 -0400
Date: Thu, 21 Apr 2005 09:26:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: yangyi <yang.yi@bmrtech.com>
Cc: "Rt-Dev@Mvista. Com" <rt-dev@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ Patch ]: Fix loopback communication latency bug
Message-ID: <20050421072624.GA808@elte.hu>
References: <1113897790.4632.161.camel@montavista2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113897790.4632.161.camel@montavista2>
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


* yangyi <yang.yi@bmrtech.com> wrote:

> Hi, Ingo
> 
> For the option PREEMPT_RT, local communication latency is very very 
> big, it is about 30 to 50 times as big as the option PREEMPT_NONE as 
> far as local ping latency is concerned. Obviously, this should be 
> fixed ASAP.
> 
> This patch fixes this bug by changing netif_rx to netif_rx_ni in 
> loopback device driver.

thanks, applied.

	Ingo
