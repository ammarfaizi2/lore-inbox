Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbRGKEhk>; Wed, 11 Jul 2001 00:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbRGKEhb>; Wed, 11 Jul 2001 00:37:31 -0400
Received: from geos.coastside.net ([207.213.212.4]:14024 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267199AbRGKEhM>; Wed, 11 Jul 2001 00:37:12 -0400
Mime-Version: 1.0
Message-Id: <p05100358b771879535bc@[207.213.214.37]>
In-Reply-To: <9igkjl$nk1$1@cesium.transmeta.com>
In-Reply-To: <3B4BC5C0.BDDC12A6@home.com>
 <9igkjl$nk1$1@cesium.transmeta.com>
Date: Tue, 10 Jul 2001 21:37:05 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
Cc: Jordan <ledzep37@home.com>, <davej@suse.de>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:27 PM -0700 2001-07-10, H. Peter Anvin wrote:
>  > According to Dave J's utility the cpu's appear to be exactly the same
>>  just as the Intel boxes said when I bought them.  What might be causing
>>  these values to be different.  And if the BIOS is setting things up
>>  incorrectly then why does Dave J's utility show the correct values?
>>  Thanks for any help.
>>
>
>/proc/cpuinfo shows "cooked" values which may be modified by the
>kernel, depending on what it knows about CPU errata or kernel
>capabilities.

Max cpuid level doesn't get cooked by the kernel, though  (at least 
not in 2.4.6).

Level 3 is the Intel's CPU serial number "feature". Didn't Intel back 
off on that? Maybe that has something to do with it, and perhaps the 
utility is doing the cooking.
-- 
/Jonathan Lundell.
