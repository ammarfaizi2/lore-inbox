Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316253AbSEQOjs>; Fri, 17 May 2002 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316250AbSEQOiB>; Fri, 17 May 2002 10:38:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15884 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316247AbSEQOh4>; Fri, 17 May 2002 10:37:56 -0400
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 17 May 2002 15:57:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        paul@engsoc.org (Paul Faure), linux-kernel@vger.kernel.org
In-Reply-To: <20020517143537.GG11512@dualathlon.random> from "Andrea Arcangeli" at May 17, 2002 04:35:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178jAR-0006gD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I didnt mention a flood of irqs. If stuff falls back to softirqd it 
> > materially harms throughput
> 
> You did implicitly becuse if there's not a flood of irq or recursive
> softirqs it cannot fall to sofitrqd.

Hardly takes a flood of IRQ's. A tiny burst of interrupts will happily
trigger it 
