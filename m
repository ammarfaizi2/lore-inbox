Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271856AbRIICvv>; Sat, 8 Sep 2001 22:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271857AbRIICvk>; Sat, 8 Sep 2001 22:51:40 -0400
Received: from dino.conectiva.com.br ([200.250.58.152]:38920 "EHLO
	dino.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S271856AbRIICvd>; Sat, 8 Sep 2001 22:51:33 -0400
From: acme@conectiva.com.br
To: Ricky Beam <jfbeam@bluetopia.net>
Subject: Re: IPX and PCMCIA
Message-ID: <1000003893.3b9ad93530d5e@www.conectiva.com.br>
Date: Sat, 08 Sep 2001 23:51:33 -0300 (BRST)
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.33.0108312012050.23852-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0108312012050.23852-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citando Ricky Beam <jfbeam@bluetopia.net>:

> (don't ask why I activated IPX on my laptop)
> 
> Kernel: 2.4.9 [Linus variety]
> Network Adapter: Intel EtherExpress 100 + 56k modem
> 
> Here's an interesting bug(let)... load any old PCMCIA network adapater
> and
> then activate IPX.  Then, rmmod the module without taking any steps to
> shutdown IPX.  You end up with the interface (eth0) actually gone with
> IPX
> still hanging on to it -- that makes it very hard to delete IPX.  The
> module
> is still loaded, however in the "deleted" state.  And
> unregister_netdev()
> keeps spewing busy alerts to every tty.
> 
> In my case, I have to shutdown the PCMCIA adapter before I suppend or
> the
> card will never come back up without physically removing it from the
> laptop.

I´m now away from my base, so I´ll only have time to work on this late next
week, but I´ll analyse this and try to see if I can come up with a fix,
thanks for the report. Oh, if somebody comes up with a fix in the meantime,
that would be great 8)

- Arnaldo
