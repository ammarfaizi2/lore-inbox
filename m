Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVFHTTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVFHTTZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVFHTTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:19:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42661 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261549AbVFHTTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:19:22 -0400
Date: Wed, 8 Jun 2005 21:18:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050608191848.GA3411@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42A7135C.5010704@cybsft.com> <42A72A53.5050809@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A72A53.5050809@cybsft.com>
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


* K.R. Foley <kr@cybsft.com> wrote:

> Well crap. Perhaps I should have tried this first. If I disable the 
> runtime selectable locking
> 
> # CONFIG_DEBUG_RT_LOCKING_MODE is not set
> 
> it seems to work fine. With the above enabled it hangs on both of my 
> SMP systems as described above. :-/

ahh ... i'll try to reproduce it that way.

	Ingo
