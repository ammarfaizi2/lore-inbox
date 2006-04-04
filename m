Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWDDN2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWDDN2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWDDN2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:28:42 -0400
Received: from [212.33.180.135] ([212.33.180.135]:60176 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932189AbWDDN2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:28:41 -0400
From: Al Boldi <a1426z@gawab.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Date: Tue, 4 Apr 2006 16:27:14 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Jake Moilanen <moilanen@austin.ibm.com>
References: <200604031459.51542.a1426z@gawab.com> <4431AF69.1000708@bigpond.net.au>
In-Reply-To: <4431AF69.1000708@bigpond.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604041627.14871.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Al Boldi wrote:
> > The default values for spa make it really easy to lock up the system.
> > Is there a module to autotune these values according to cpu/mem/ctxt
> > performance?
>
> Jake Moilanen had a genetic algorithm autotuner for Zaphod at one time
> which I believe he ported over to PlugSched

Would this be a load-adaptive dynamic tuner?

What I meant was a lock-preventive static tuner.  Something that would take 
hw-latencies into account at boot and set values for non-locking console 
operation.

> I could generate a patch to gather the statistic again and make them
> available via /proc if you would like to try a user space version of
> Jake's work (his was in kernel).

That would be great!

Thanks!

--
Al

