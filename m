Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281277AbRKRGR2>; Sun, 18 Nov 2001 01:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281470AbRKRGRS>; Sun, 18 Nov 2001 01:17:18 -0500
Received: from www.wen-online.de ([212.223.88.39]:64274 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S281277AbRKRGRP>;
	Sun, 18 Nov 2001 01:17:15 -0500
Date: Sun, 18 Nov 2001 07:17:02 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm
 problems)
In-Reply-To: <20011117165441.S1381@athlon.random>
Message-ID: <Pine.LNX.4.33.0111180711260.644-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2001, Andrea Arcangeli wrote:

> If all your hardware is PCI nobody will make an allocation from the
> ZONE_DMA classzone and so kswapd will never loop on the ZONE_DMA, as
> instead can happen with -ac as soon as the ZONE_DMA becomes unfreeable
> and under the low watermark (and "unfreeable" of course also means all
> anon not locked memory but no swap installed in the machine).

We don't fallback to ZONE_DMA anymore?  (good)

	-Mike

