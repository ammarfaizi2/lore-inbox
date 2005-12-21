Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVLUWeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVLUWeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLUWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:34:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:36518 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751186AbVLUWeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:34:15 -0500
Date: Wed, 21 Dec 2005 23:33:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lee Revell <rlrevell@joe-job.com>
cc: 7eggert@gmx.de, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: remove CONFIG_UID16
In-Reply-To: <1134844168.11227.3.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0512212332450.605@yvahk01.tjqt.qr>
References: <5kCbe-45z-7@gated-at.bofh.it>  <E1EnZIZ-0003Px-3c@be1.lrz>
 <1134844168.11227.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > It seems noone noticed that CONFIG_UID16 was accidentially always
>> > disabled in the latest -mm kernels.
>> > 
>> > Is there any reason against removing it completely?
>> 
>> Maybe embedded systems.
>
>The comments in the code say it's for backwards compatibility:
>
>(from include/linux/highuid.h)
>
> *
> * CONFIG_UID16 is defined if the given architecture needs to
> * support backwards compatibility for old system calls.
> *
>
>This implies that removing it would break some applications, right?


So what are the most recent apps that still use them, and for what kernel 
were they originally designed?



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
