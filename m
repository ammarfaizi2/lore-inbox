Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271370AbRIFQpq>; Thu, 6 Sep 2001 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271365AbRIFQpg>; Thu, 6 Sep 2001 12:45:36 -0400
Received: from spike.porcupine.org ([168.100.189.2]:35337 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S271370AbRIFQpa>; Thu, 6 Sep 2001 12:45:30 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <E15f2BJ-0008R0-00@the-village.bc.nu> "from Alan Cox at Sep 6, 2001
 05:39:09 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 6 Sep 2001 12:45:50 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906164550.AD01BBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> > 127.0.0.2 is not local on any of my systems. The only exceptions
> > are some Linux boxen that I did not ask to do so.
> 
> Todays reading is from RFC990 in the book of Reynolds & Postel, page number 6
> 
> And the IETF spake thusly
> 
> |  The class A network number 127 is assigned the "loopback" function, that
> | is, a datagram sent by a higher level protocol to a network 127 address
> | should loop back inside the host. No datagram "sent" to a network 127
> | address should ever appear on any network anywhere.

That's routing.

I was talking about accepting connections. None of my systems
accepts connections on 127.0.0.2, except for a couple Linux boxen
that I did not ask to do so.

	Wietse
