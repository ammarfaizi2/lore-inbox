Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946860AbWKAQLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946860AbWKAQLy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946919AbWKAQLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:11:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:26199 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946860AbWKAQLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:11:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GJ5//3AbGbGfETIGSnkP3wqCuAkZdGza9IWN0cxsiPt96+ArnHSeDu6EOQR2cRPem+/ycWy/48dERi2VeO4yS9NQ/MVq9LcE0fRDsTDy5LyYBh/YYyKM9NMBb6TqS6XEk50+Jo8lTTNw+h8Sqfu1qyyAI3+W/CmSZLRZhz5KwdA=
Message-ID: <6278d2220611010811r72424249h2a2184d7e466b32f@mail.gmail.com>
Date: Wed, 1 Nov 2006 16:11:51 +0000
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: jclark@metricsystems.com
Subject: Re: sky2 driver causes kernel crash as of 2.6.18.1
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Netdev" <netdev@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Clark wrote:
> I have been compiling kernels from 2.6.16.16 on to see if there is any
> improvement
> in the Sky2 driver. The most recent official kernel version, 2.6.18.1,
> as of 10/31/06
> seems to still have problems.
>
> The crash debug splat indicates that the transmit routine was being
> executed when
> the final crash occured. But before the crash there were a series of
> diagnostics from
> the driver:
>
> NETDEV WATCHDOG: eth4: transmit time out
> sky2 eth4: tx timeout
> sky2 hardware hung? flushing
>
> messages.
>
> Is there any better driver in a 'unstable' kernel that someone has
> tested sufficiently?
>
> Thanks
> John Clark

I've been using sky2 v1.9 (in eg linux-2.6.19-rc3) on two sky2
platforms, running 100s of gigabytes via NFSv4 and CIFS without
problem. In earlier versions, I'd hit a race after a few GBs at high
load; Stephen Hemminger has done a great job.
-- 
Daniel J Blueman
