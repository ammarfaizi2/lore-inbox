Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276211AbRI1SEO>; Fri, 28 Sep 2001 14:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276214AbRI1SEF>; Fri, 28 Sep 2001 14:04:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276212AbRI1SEA>; Fri, 28 Sep 2001 14:04:00 -0400
Subject: Re: Adding a printk in start_secondary breaks 2.4.10, not 2.4.9 ??
To: fletch@aracnet.com
Date: Fri, 28 Sep 2001 19:09:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <946825303.1001674205@[10.10.1.2]> from "Martin J. Bligh" at Sep 28, 2001 10:50:05 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n24b-0007tz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> FWIW, I still think that means that the console locking changes are broken 
> -
> adding a printk shouldn't panic the kernel. I'll go look at the console 
> locking
> changes (*and* fix my disgusting hack ;-) )

I suspect the panic has nothing to do with adding the printk, but merely
that the timing patterns of your disgusting hack have changed

Happy logical analysers 8)
