Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVHBFrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVHBFrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVHBFrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:47:45 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:12961 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261379AbVHBFre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:47:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Tue, 2 Aug 2005 15:49:48 +1000
User-Agent: KMail/1.8.1
Cc: tony@atomide.com, tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
References: <200508021443.55429.kernel@kolivas.org>
In-Reply-To: <200508021443.55429.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021549.48711.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 02:43 pm, Con Kolivas wrote:
> This has slightly more build fixes than the last one I posted and boots and
> runs fine on my laptop. So far at absolute idle it appears this pentiumM
> 1.7 is claiming to have _25%_ more battery life. I'll need to investigate
> further to see the real power savings.

As a crude data point of idle system running a full kde desktop environment on 
powersave with minimal backlight and just chatting on IRC I find it's just 
under 10% battery life difference. I have confirmed in the past the accuracy 
of the remaining capacity exported by the battery and the time to complete 
discharge. This saving is similar in magnitude to the 1000->100Hz savings of 
7% mentioned on other threads. While nothing like the 25% initially suggested 
it is still significant. Anyone with a more accurate means of testing this 
interested?

Cheers,
Con
