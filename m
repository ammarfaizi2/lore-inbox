Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285589AbRLGWBO>; Fri, 7 Dec 2001 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285584AbRLGWBE>; Fri, 7 Dec 2001 17:01:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285577AbRLGWAt>; Fri, 7 Dec 2001 17:00:49 -0500
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
To: davidm@hpl.hp.com
Date: Fri, 7 Dec 2001 22:08:51 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15377.13976.342104.636304@napali.hpl.hp.com> from "David Mosberger" at Dec 07, 2001 01:37:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CTAp-0007VX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>>> On Fri, 7 Dec 2001 16:52:07 -0200 (BRST), Marcelo Tosatti <marcelo@conectiva.com.br> said:
>   Marcelo> I'm really not willing to apply this kludge...
> 
> Do you agree that it should always be safe to call printk() from C code?

Sounds a good goal, but surely thats up to the arch code to get right
