Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271344AbRIFQfQ>; Thu, 6 Sep 2001 12:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271365AbRIFQfG>; Thu, 6 Sep 2001 12:35:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2576 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271344AbRIFQfA>; Thu, 6 Sep 2001 12:35:00 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
To: wietse@porcupine.org (Wietse Venema)
Date: Thu, 6 Sep 2001 17:39:09 +0100 (BST)
Cc: saw@saw.sw.com.sg (Andrey Savochkin),
        matthias.andree@gmx.de (Matthias Andree),
        wietse@porcupine.org (Wietse Venema), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010906155811.BC78DBC06C@spike.porcupine.org> from "Wietse Venema" at Sep 06, 2001 11:58:11 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15f2BJ-0008R0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 127.0.0.2 is not local on any of my systems. The only exceptions
> are some Linux boxen that I did not ask to do so.

Todays reading is from RFC990 in the book of Reynolds & Postel, page number 6

And the IETF spake thusly

|  The class A network number 127 is assigned the "loopback" function, that
| is, a datagram sent by a higher level protocol to a network 127 address
| should loop back inside the host. No datagram "sent" to a network 127
| address should ever appear on any network anywhere.



