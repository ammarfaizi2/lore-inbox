Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271852AbRICXF7>; Mon, 3 Sep 2001 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271855AbRICXFt>; Mon, 3 Sep 2001 19:05:49 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:4871 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S271852AbRICXFh>;
	Mon, 3 Sep 2001 19:05:37 -0400
Message-Id: <200109031544.f83Fidbr002589@sleipnir.valparaiso.cl>
To: "David S. Miller" <davem@redhat.com>
cc: ak@suse.de, alan@lxorguk.ukuu.org.uk, willy@debian.org, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] documented Oops running big-endian reiserfs on parisc architecture 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Mon, 03 Sep 2001 01:15:30 MST." <20010903.011530.62340995.davem@redhat.com> 
Date: Mon, 03 Sep 2001 11:44:39 -0400
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> said:
> IP header length is measured in octets, so how is this possible?
> :-)

1 octet == 8 bits in RFC-speak. "Byte" is the name given to character
units.  There were machines around with non-8-bit bytes. AFAIR, DEC PDP-10
had the options of 6, 7, or 8 bits/byte in 36 bit words. Purely historical
now, since (AFAIK) everybody has agreed with IBM (S/360?) that 1 byte == 8
bits. As Brian Reid (IIRC) used to say: "It is spelled 'o-c-t-e-t' and
pronounced 'byte'"
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

