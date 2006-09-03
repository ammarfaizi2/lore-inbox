Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWICLPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWICLPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 07:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWICLPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 07:15:44 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:10908 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751233AbWICLPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 07:15:43 -0400
From: Matthias Dahl <mlkernel@mortal-soul.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: sluggish system responsiveness under higher IO load
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608061200.37701.mlkernel@mortal-soul.de> <20060808190241.GB11829@suse.de> <20060810122853.GS11829@suse.de>
In-Reply-To: <20060810122853.GS11829@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 3 Sep 2006 13:15:04 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200609031315.04308.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 14:28, Jens Axboe wrote:

>> > [...] It would be
>> > nice if you could gather vmstat 1 info during a problematic period.
>> > blktrace info could also be very useful:
>>
>> - Does disabling preemtion (CONFIG_PREEMPT_NONE=y) help?

>  http://www.mortal-soul.de/blktrace.log.bz2
>  http://www.mortal-soul.de/vmstat.log.bz2

Jens, did you get these? Just wondered because it's been almost a month since. 
BTW... just a few more observations:

1. running an OpenGL app like ET and just having some compiling done in the
   background or some light disk io gives distorted sound playback as well as
   very poor OpenGL performance

2. switching between console and xorg also results in short sound distortions
   even though the cpu load is almost zero

Maybe those and the original problem are somehow related.

Thanks...
matthew.

-- 
VGER BF report: U 0.500007
