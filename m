Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268503AbRHAWXk>; Wed, 1 Aug 2001 18:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268502AbRHAWXb>; Wed, 1 Aug 2001 18:23:31 -0400
Received: from mail.inf.elte.hu ([157.181.161.6]:16558 "EHLO mail.inf.elte.hu")
	by vger.kernel.org with ESMTP id <S268497AbRHAWXT>;
	Wed, 1 Aug 2001 18:23:19 -0400
Date: Thu, 2 Aug 2001 00:23:27 +0200 (CEST)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <Pine.A41.4.31.0108012357130.28452-100000@pandora.inf.elte.hu>
Message-ID: <Pine.A41.4.31.0108020011350.28452-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

sorry, I forgot something.
when kswapd was eating the cpu, there was 3m of free ram, and 19m of
buffer cache.
I thought it was about the network, but it seems not.

szabi@traktor:~# free
             total       used       free     shared    buffers     cached
Mem:        159356     155480       3876        684       1132      15464
-/+ buffers/cache:     138884      20472
Swap:            0          0          0
szabi@traktor:~#

Bye,
Szabi


