Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSI0Gac>; Fri, 27 Sep 2002 02:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSI0Gab>; Fri, 27 Sep 2002 02:30:31 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:50704 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261644AbSI0Gab>; Fri, 27 Sep 2002 02:30:31 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <Pine.LNX.4.44.0209262116550.1632-100000@montezuma.mastecende.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Fri, 27 Sep 2002 08:35:33 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, twaugh@redhat.com,
       serial24@macrolink.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17uoir-00086v-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahh return of the 9835 =) This POS never goes away...

Just curions, what does POS mean here? :)

These "ST Lab" 2S1P cards are the only kind of PCI I/O card that I was
able to find here at a reasonable price (about $25), and it took me
quite some time to find a company that actually sells them (in stock,
not only in the price list - but if asked, "maybe in two weeks" for 3
months now...).  In general, it is difficult to buy anything non-USB
here at reasonable (not "industrial PC") prices.  Without these cards,
I'd have to buy USB hubs and USB/serial converters instead...

The patch fixes a bug for _all_ PCI parallel+serial cards, and does
not add NM9835 support yet (I'd like to submit that next - I would
really like to see it in the standard kernel).

Thanks,
Marek

