Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbVH0KHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVH0KHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 06:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVH0KHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 06:07:32 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:13973 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030355AbVH0KHc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 06:07:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KUi0242O7TredUNtWGZLdiNqVt9sStk85Qz/+3Nr5NfgcdZsltDHPqwknAEa7QcnuHhaSWI5MiWHtcGA6olGaFejdnQs8mW8b3LTqRZEac89ysG+o9SrcIqS5cRmZUWauj4X532P9MndT1ICzA543RM3+Z0VDx6AwyWGT2lnPwE=
Message-ID: <6bffcb0e050827030772a47f57@mail.gmail.com>
Date: Sat, 27 Aug 2005 12:07:29 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Kernel 2.6.13-rc7 Latency Question
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0508270524340.14692@p34>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0508270524340.14692@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/27/05, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> 
> These options are self-explanatory:
> 
>       x x          ( ) No Forced Preemption (Server)                     x
> x    x x          ( ) Voluntary Kernel Preemption (Desktop)             x
> x    x x          (X) Preemptible Kernel (Low-Latency Desktop)          x x
> 
> 
> 
> It says 100 HZ or 250 HZ is good for SMP systems; however, what if I am
> using a P4 machine with 1 CPU (HT), is 1000HZ still the way to go, as its
> not really 2 *REAL* cpus?

I use 1000HZ on my P4 machine, HT enabled, staircase scheduler.

See LKML topic "Schedulers benchmark" if you want more
information/benchmarks results.

Regards,
Michal Piotrowski
