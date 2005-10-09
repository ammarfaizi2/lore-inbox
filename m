Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVJISlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVJISlB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVJISlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 14:41:00 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:27319 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932250AbVJISlA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 14:41:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pZWDY30HJMaIFoF2mCNQ5q8j/qD4FB2KeMdEzM+P7liNS7cu6+cpiXDCrYXOM6tQqRd6Y2TAb8dDdRVUErWrIqzt9JBGTQ+UyD3owEhQVEQI2B9sorzzXIDP0hFFEd1EnUJ7BH2uiQ/BjTTfKeBJNUBmFAIs2159E2cAeG6Mn/k=
Message-ID: <b9a245c10510091140q78c2480dqb095a7cdab12932e@mail.gmail.com>
Date: Mon, 10 Oct 2005 00:10:59 +0530
From: Vivek Kutal <vivek.kutal@gmail.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: Need for SHIFT and MASK
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510091423.24660.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
	 <200510091423.24660.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> This is usally table driven and someone has to set up
> this "Page Translation Tables". That's a job of the Linux kernel.

Yes setting up the page table entries is the job of the kernel , but
for that we need to put the physical add. of the page and some bits
(present,access writes etc) in the entry, once it is done the main job
of translation which requires the masking and shifting is done by the
processor whenever that page is referenced .
so why these macros are present in the kernel?


--
Thanks and Regards
Vivek Kutal
http://vivekkutal.blogspot.com

"Live as if you were to die tomorrow. Learn as if you were to live forever."
