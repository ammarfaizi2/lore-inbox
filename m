Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUBSHzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUBSHzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:55:23 -0500
Received: from av1-1-sn4.m-sp.skanova.net ([81.228.10.116]:54957 "EHLO
	av1-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S266666AbUBSHzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:55:13 -0500
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Christoph Stueckjuergen <christoph.stueckjuergen@siemens.com>,
       Robert Love <rml@tech9.net>
Subject: Re: 2.6.1 Scheduler Latency Measurements (Preemption diabled/enabled)
Date: Wed, 18 Feb 2004 22:00:04 +0100
User-Agent: KMail/1.6.51
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402182200.04754.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Stueckjuergen wrote:

>Hi,
>
>I performed a series of measurements comparing scheduler latency of a 2.6.1 
>kernel with preemption enabled and disabled on an AMD Elan (i486 compatible) 
>with 133 Mhz clock frequency.

OK, then you have worse hardware than I had when I started to measure
latency :-)

> - - - interesting way of trigger and measure deleted - - -

> The results are:
> "loaded" system, 10.000 samples
> average scheduler latency (preemption enabled / disabled): 170 us / 232 us
> minimum scheduler latency (preemption enabled / disabled): 49 us / 43 us
> maximum scheduler latency (preemption enabled / disabled): 840 us / 1063 us
> 
> "unloaded" system, 10.000 samples
> average scheduler latency (preemption enabled / disabled): 50 us / 44 us
> minimum scheduler latency (preemption enabled / disabled): 46 us / 41 us
> maximum scheduler latency (preemption enabled / disabled): 233 us / 215 us
> 

Robert Love said:
> That said, I would of expected slightly better numbers.

I would say that the numbers are quite good :-)
For comparation check
  http://www.gardena.net/benno/linux/audio/

There are some load tests there that you can use
to generate load: disk access, memory pressure, X11, ...

Note that more memory can result in worse latency, longer linked lists
to walk...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
