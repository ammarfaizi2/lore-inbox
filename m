Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVIPWM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVIPWM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 18:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVIPWM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 18:12:59 -0400
Received: from juno.lps.ele.puc-rio.br ([139.82.40.34]:23466 "EHLO
	juno.lps.ele.puc-rio.br") by vger.kernel.org with ESMTP
	id S1750720AbVIPWM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 18:12:58 -0400
Message-ID: <60542.200.141.101.221.1126908642.squirrel@correio.lps.ele.puc-rio.br>
In-Reply-To: <432A6923.2070000@pobox.com>
References: <61637.200.141.106.169.1126660632.squirrel@correio.lps.ele.puc-rio.br><60519.200.141.106.169.1126727337.squirrel@correio.lps.ele.puc-rio.br><43290893.7070207@pobox.com><1126790860.19133.75.camel@localhost.localdomain><61929.200.141.106.169.1126815191.squirrel@correio.lps.ele.puc-rio.br>
       <1126823405.7034.14.camel@localhost.localdomain>
    <61375.200.141.106.169.1126842173.squirrel@correio.lps.ele.puc-rio.br>
    <432A6923.2070000@pobox.com>
Date: Fri, 16 Sep 2005 19:10:42 -0300 (BRT)
Subject: Re: libata sata_sil broken on 2.6.13.1
From: "Matheus Izvekov" <izvekov@lps.ele.puc-rio.br>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: izvekov@lps.ele.puc-rio.br, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
User-Agent: SquirrelMail/1.4.3a-6.FC2
X-Mailer: SquirrelMail/1.4.3a-6.FC2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Essentially that is what happened.  Albert's patch simply fixed it
> another way.
>
> ATA is a bit annoying in that, we try to "know" when an interrupt is
> expected.  There is no 100% solution that simply allows us to check for
> pending interrupts, without side effects.
>
> Thus the explosion when unexpected interrupts are received.
>

What do you think would be proper fix, this patch from Albert, or maybe
just trapping the interrupts (plus not have the IRQ shared with other
devices?). Also, what keeps Albert's patch from making into mainline, it
just needs more testing or are there any known problems?

> 	Jeff

Thanks for your support.

