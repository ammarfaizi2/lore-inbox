Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVJZXXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVJZXXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 19:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVJZXXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 19:23:00 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:6311 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751512AbVJZXW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 19:22:59 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Alexander Skwar <listen@alexander.skwar.name>
Subject: Re: Another report of "kernel BUG at mm/slab.c:2839!".
Date: Thu, 27 Oct 2005 09:25:26 +1000
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, pi@pihost.us
References: <435F8316.9020006@mid.message-center.info>
In-Reply-To: <435F8316.9020006@mid.message-center.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510270925.26773.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005 11:22 pm, Alexander Skwar wrote:
> Hello.
>
> Just like Anthony Martinez <pi <at> pihost.us> reported
> at  2005-09-24 17:35:43, I'm also hitting kernel BUG at mm/slab.c:2839!.
>
> I cannot really reproduce it. It just happens from
> time to time.
>
> [15:21:02 vz6tml@dewup-ww02:~] $ uname -a
> Linux dewup-ww02 2.6.13-ck8.03.reiser-stat.megaraid_newgen.no-preempt #2
> SMP Mon Oct 24 10:01:43 CEST 2005 i686 Intel(R) Xeon(TM) CPU 2.40GHz
> GenuineIntel GNU/Linux
>
> [15:21:30 vz6tml@dewup-ww02:~] $ cat /proc/version
> Linux version 2.6.13-ck8.03.reiser-stat.megaraid_newgen.no-preempt
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you were running a vanilla kernel you'd get full support from the mailing 
list. If you were running plain ck8 I could offer you limited support. But 
adding your own patches makes it impossible for us to know what your code 
looks like and that you haven't merged incompatible code wrongly. Only the 
person who merged the code would be able to provide you with support.

My advice to you is try a mainline kernel release that has the features you 
need and see if the bug exists. Then you'll get more response from the 
mailing list.

Cheers,
Con
