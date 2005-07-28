Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVG1Hq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVG1Hq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVG1Hoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:44:38 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57280 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261336AbVG1Hmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:42:54 -0400
Date: Thu, 28 Jul 2005 09:42:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] Real-Time Preemption V0.7.51-38: fix compile bug in drivers/block/paride/pseudo.h
Message-ID: <20050728074225.GA20777@elte.hu>
References: <42E7AF99.8070509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E7AF99.8070509@gmail.com>
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


* Luca Falavigna <dktrkranz@gmail.com> wrote:

> This patch, built against kernel version 2.6.13-rc3, fixes a small bug 
> in drivers/block/paride/pseudo.h which prevents its related drivers 
> from being compiled successfully when RT patch (version 0.7.51-38) is 
> compiled in. This is due to the new definition of DEFINE_SPINLOCK 
> macro, which does not longer accept additional attributes.

thanks - applied.

	Ingo
