Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRLIBKZ>; Sat, 8 Dec 2001 20:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280970AbRLIBKQ>; Sat, 8 Dec 2001 20:10:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280961AbRLIBKH>; Sat, 8 Dec 2001 20:10:07 -0500
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
To: davidm@hpl.hp.com
Date: Sun, 9 Dec 2001 01:15:25 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <15378.46887.160213.680268@napali.hpl.hp.com> from "David Mosberger" at Dec 08, 2001 04:58:15 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CsYv-0003QO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Alan> So we make sure our initial console code doesnt need udelay(),
>   Alan> or set an initial safe default like 25MHz
> 
> So someone is going to maintain a list of what a console driver can
> and cannot do for all 12+ ports in existence?
> 
> The alternative is to do:

And break the ability for non broken setups to debug SMP boot up. Lets do
the job properly.
