Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbRGKE1u>; Wed, 11 Jul 2001 00:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267198AbRGKE1l>; Wed, 11 Jul 2001 00:27:41 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35089 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267197AbRGKE1f>; Wed, 11 Jul 2001 00:27:35 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Discrepancies between /proc/cpuinfo and Dave J's x86info
Date: 10 Jul 2001 21:27:33 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9igkjl$nk1$1@cesium.transmeta.com>
In-Reply-To: <3B4BC5C0.BDDC12A6@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3B4BC5C0.BDDC12A6@home.com>
By author:    Jordan <ledzep37@home.com>
In newsgroup: linux.dev.kernel
> 
> According to Dave J's utility the cpu's appear to be exactly the same
> just as the Intel boxes said when I bought them.  What might be causing
> these values to be different.  And if the BIOS is setting things up
> incorrectly then why does Dave J's utility show the correct values? 
> Thanks for any help.
> 

/proc/cpuinfo shows "cooked" values which may be modified by the
kernel, depending on what it knows about CPU errata or kernel
capabilities.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
