Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbVKXJlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbVKXJlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVKXJlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:41:18 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:49827 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932625AbVKXJlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:41:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Marcel Zalmanovici <MARCEL@il.ibm.com>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
Date: Thu, 24 Nov 2005 20:40:59 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>
References: <OF507D27BA.6B51F19A-ONC22570C3.002E62D2-C22570C3.002F0C99@il.ibm.com>
In-Reply-To: <OF507D27BA.6B51F19A-ONC22570C3.002E62D2-C22570C3.002F0C99@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511242041.00586.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2005 19:33, Marcel Zalmanovici wrote:
> Hi Con,
>
> I've tried the pthread_join theory.
> pthread_join completes very fast, no evidence on it being the perpetrator
> here.
>
> I've ran your ps -... idea in a different term window every ms while the
> test was running. It created a large file so I won't mail it to you, but
> both me and Muli observed that once the thread ends it quickly disappears
> from the ps list.
>
> I've also ran Muli's idea and added gettimeofday calls.
> Here's the altered code and output:
>
> (See attached file: idle.log)(See attached file: sched_test.c)
>
> As you can see, if a thread already finished pthread_join returns in a
> split second.
>
> Any other ideas are welcome :-)

Profile the actual application?

> P.S. - I agree that Lotus isn't ideal for this kind of conversations, but
> that's what IBM is using.

It was tongue in cheek ;) Well that should still not stop you from replying 
below the original thread.

Cheers,
Con
