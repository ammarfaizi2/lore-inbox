Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269512AbRGaWdF>; Tue, 31 Jul 2001 18:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269508AbRGaWcp>; Tue, 31 Jul 2001 18:32:45 -0400
Received: from anime.net ([63.172.78.150]:18703 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S269507AbRGaWcm>;
	Tue, 31 Jul 2001 18:32:42 -0400
Date: Tue, 31 Jul 2001 15:32:39 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Jussi Laako <jlaako@pp.htv.fi>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B672C6B.9AC418B0@pp.htv.fi>
Message-ID: <Pine.LNX.4.30.0107311526360.13810-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 1 Aug 2001, Jussi Laako wrote:
> I'd be very happy with full data journalling even with 50% performance
> penalty... There are applications that require extreme data integrity all
> times no matter what happens.

How about an idea I proposed a while back, 'integrity loopback'?

A loopback device which writes a CRC with each block and checks the CRC
when read back.

So if you have a flaky DMA controller, bad cables, etc you will know
instantly. It would at least help catch the 'silent corruption' cases.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

