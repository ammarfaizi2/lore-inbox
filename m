Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135522AbRDWTnJ>; Mon, 23 Apr 2001 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135523AbRDWTmt>; Mon, 23 Apr 2001 15:42:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30727 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135522AbRDWTmr>; Mon, 23 Apr 2001 15:42:47 -0400
Subject: Re: Can't compile 2.4.3 with agcc
To: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 23 Apr 2001 20:43:29 +0100 (BST)
Cc: rmk@arm.linux.org.uk (Russell King), papadako@csd.uoc.gr (mythos),
        linux-kernel@vger.kernel.org
In-Reply-To: <24644.988041173@redhat.com> from "David Woodhouse" at Apr 23, 2001 04:52:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rmF9-0000Ii-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +		printk(KERN_EMERG "This is usually caused by a buggy compiler (perhaps pgcc?)\n");
> +		printk(KERN_EMERG "Cannot continue.\n");
> +		for (;;) ;

At least make the final printk a panic..
