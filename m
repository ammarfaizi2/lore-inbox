Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSHGPdR>; Wed, 7 Aug 2002 11:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSHGPdR>; Wed, 7 Aug 2002 11:33:17 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:33541 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318541AbSHGPdQ>; Wed, 7 Aug 2002 11:33:16 -0400
Date: Wed, 7 Aug 2002 17:36:25 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at tg3.c:1557
In-Reply-To: <20020807.074838.106638568.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208071729370.3705-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David S. Miller wrote:

>    From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
>    Date: Wed, 7 Aug 2002 16:49:24 +0200 (CEST)
> 
>    Sorry, same problem as before. It looks like the spinlocked write method 
>    does not work on the BCM5701 chip :-(
> 
> I'm still not entirely convinced of this :-)
> Backout all of your changes and try this patch instead:
> 
[snip]

Now, the change leads to two more timeouts, from tg3_reset_hw and 
tg3_halt_hw. I should however point out that these do not happen during 
module loading, but only when doing 'network start'.

How can I help to track this down?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

