Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316240AbSEQOcG>; Fri, 17 May 2002 10:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316241AbSEQOcF>; Fri, 17 May 2002 10:32:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8204 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316240AbSEQOcE>; Fri, 17 May 2002 10:32:04 -0400
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 17 May 2002 15:51:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        paul@engsoc.org (Paul Faure), linux-kernel@vger.kernel.org
In-Reply-To: <20020517125529.GC11512@dualathlon.random> from "Andrea Arcangeli" at May 17, 2002 02:55:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178j4i-0006eT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For a 10Mbit ne2k it ought to be if its done with sched fifo. For serious
> > devices its not. The ksoftirqd bounce blows everything out of cache and is
> > easily measured
> 
> if you're under a flood of irq ksoftirqd or not won't make differences

I didnt mention a flood of irqs. If stuff falls back to softirqd it 
materially harms throughput
