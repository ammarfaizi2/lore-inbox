Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUB1LSs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUB1LSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:18:48 -0500
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:25509 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261612AbUB1LSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:18:45 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: sched domains kernbench improvements
Date: Sat, 28 Feb 2004 22:18:41 +1100
User-Agent: KMail/1.6
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200402282159.58452.kernel@kolivas.org> <40407847.7040403@cyberone.com.au>
In-Reply-To: <40407847.7040403@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402282218.41590.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004 22:15, Nick Piggin wrote:
> Con Kolivas wrote:
> >Hi Nick
> >
> >>So it is more a matter of tuning than anything fundamental
> >
> >Geez I know how you feel... :-D
> >
> >
> >I tried it on the X440 with sched smt disabled
> >
> >better than before but still slower than vanilla on half load; however
> > better than vanilla on optimal and full load now! I wonder whether the
> > worse result on half load is as relevant since this is 8x HT cpus?
>
> Thanks. Yep the drop off at half load is to be expected with
> CONFIG_SCHED_SMT turned off.

Will this affect the SCHED_SMT performance and should I do a round of benchies 
with this enabled?

Con
