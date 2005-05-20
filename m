Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVETERR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVETERR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 00:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVETERR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 00:17:17 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:7013 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261294AbVETERN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 00:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bo77NIXf+bKI4oXtQ1MDMoQh0oDYwvCZwhgdR71te7Bei+AyyfkelHtgSfYKPogXFC4Bgdm8RUpk7wfCaKYk/ijDI3hHkmx6LZVFyDHTNHIL1QCgaAh+WqXjkORWlz6lcGSgRjjP7kbbTJeL8a3RlwU9595LOFVgECxcPV667dw=
Message-ID: <855e4e460505192117155577e@mail.gmail.com>
Date: Thu, 19 May 2005 21:17:11 -0700
From: chen Shang <shangcs@gmail.com>
Reply-To: chen Shang <shangcs@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] kernel <linux-2.6.11.10> kernel/sched.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <428D58E6.8050001@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <855e4e4605051909561f47351@mail.gmail.com>
	 <428D58E6.8050001@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Chen,
> With the added branch and the extra icache footprint, it isn't clear
> that this would be a win.
> 
> Also, you didn't say where your statistics came from (what workload).
> 
> So you really need to start by demonstrating some increase on some workload.
> 
> Also, minor comments on the patch: please work against mm kernels,
> please follow
> kernel coding style, and don't change schedstat output format in the
> same patch
> (makes it easier for those with schedstat parsing tools).
> 
Hi Nick,

Thank you very much for your comments. This is the first time of my
kernel hacking. I will reduce the lines of changes as much as
possible. As regard to the statistics, there are just count, ie, the
total number of priority-recalculations vs. the number of priority
changed from the former recalculation.

Thanks again,
-chen
