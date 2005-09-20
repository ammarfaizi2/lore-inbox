Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVITEBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVITEBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVITEBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:01:46 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:34718 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S964862AbVITEBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:01:45 -0400
Subject: Re: [Question] How to understand Clock-Pro algorithm?
From: Song Jiang <sjiang@lanl.gov>
To: liyu <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
In-Reply-To: <432F7DD5.6050204@ccoss.com.cn>
References: <432F7DD5.6050204@ccoss.com.cn>
Content-Type: text/plain
Message-Id: <1127188898.3130.52.camel@moon.c3.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-16) 
Date: Mon, 19 Sep 2005 22:01:38 -0600
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 21:11, liyu wrote:

>     My question is out:As this paper words, the number of cold page is 
> total of resident cold pages
> and non-resident pages. It's the seem number of non-resident cold pages 
> can not beyond M at all!

You are right. So the total number of pages (non-resident + resident)
around the clock is no more than 2m 
(m is the memory size in pages).

>    
>     I also have more questions on CLOCK-Pro. but this question is most 
> doublt for me.
> 
  I am happy to help. I also have the clock-pro simulator that
almost exactly simulates what's described in the paper. Let me
know if you want it.

   Song Jiang

> 
> liyu
> 
>    
> 
> 
> 
>    
>    
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

