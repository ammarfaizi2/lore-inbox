Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVG1Xs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVG1Xs7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVG1Xs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:48:58 -0400
Received: from fmr23.intel.com ([143.183.121.15]:32226 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262171AbVG1XsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:48:25 -0400
Message-Id: <200507282348.j6SNmLg02429@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Date: Thu, 28 Jul 2005 16:48:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWTzO/Z0mbz+OreSQiOKP8Bp6ovgQAAPQOA
In-Reply-To: <42E96B8C.6010005@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote on Thursday, July 28, 2005 4:35 PM
> Wake balancing provides an opportunity to provide some input bias
> into the load balancer.
> 
> For example, if you started 100 pairs of tasks which communicate
> through a pipe. On a 2 CPU system without wake balancing, probably
> half of the pairs will be on different CPUs. With wake balancing,
> it should be much better.

Shouldn't the pipe code use synchronous wakeup?


> I hear you might be having problems with recent 2.6.13 kernels? If so,
> it would be really good to have a look that before 2.6.13 goes out the
> door.

Yes I do :-(, apparently bumping up cache_hot_time won't give us the
performance boost we used to see.

- Ken

