Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269519AbUICSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269519AbUICSee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269748AbUICSeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 14:34:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8599 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269704AbUICSbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 14:31:50 -0400
Date: Fri, 3 Sep 2004 20:33:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Message-ID: <20040903183325.GA11225@elte.hu>
References: <OFF6D4A65F.6B636459-ON86256F04.00651ACF@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF6D4A65F.6B636459-ON86256F04.00651ACF@raytheon.com>
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


* Mark_H_Johnson@Raytheon.com <Mark_H_Johnson@Raytheon.com> wrote:

> I suppose you meant
>  #define inline

yeah ...

> instead (which throws a warning about a duplicate definition; can I
> ignore it?)

yeah, ought to be fine. (you can do an #undef inline for a cleaner
compile).

	Ingo
