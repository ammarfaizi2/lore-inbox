Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWDCX34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWDCX34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWDCX34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:29:56 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:15489 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964944AbWDCX3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:29:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Tue, 4 Apr 2006 09:29:47 +1000
User-Agent: KMail/1.9.1
Cc: Peter Williams <pwil3058@bigpond.net.au>, Al Boldi <a1426z@gawab.com>
References: <200604031459.51542.a1426z@gawab.com> <4431A9E7.40406@bigpond.net.au>
In-Reply-To: <4431A9E7.40406@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604040929.48198.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 April 2006 09:04, Peter Williams wrote:
> Al Boldi wrote:

> > Is there a module to autotune these values according to cpu/mem/ctxt
> > performance?

I think you're thinking of Jake's genetic algorithms (separate patch). They 
tune the zaphod scheduler but bear in mind the limitation of such an 
algorithm is they can only tune for one workload which means that if you have 
two workloads running concurrently with different requirements, the other 
will suffer.

> > Also, different schedulers per cpu could be rather useful.
> > Peter Williams wrote:
> I think that would be dangerous.  However, different schedulers per
> cpuset might make sense but it involve a fair bit of work.

I'm curious. How do you think different schedulers per cpu would be useful?

Cheers,
Con
