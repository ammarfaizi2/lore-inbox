Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262154AbSJVEzz>; Tue, 22 Oct 2002 00:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJVEzz>; Tue, 22 Oct 2002 00:55:55 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:35303 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S262154AbSJVEzz>; Tue, 22 Oct 2002 00:55:55 -0400
Message-ID: <3DB4DBC8.8647E32E@pp.inet.fi>
Date: Tue, 22 Oct 2002 08:02:00 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@hvrlab.org>
CC: "David S. Miller" <davem@rth.ninka.net>, Sandy Harris <sandy@storm.ca>,
       Mitsuru KANDA <mk@linux-ipv6.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cryptoapi-devel@kerneli.org,
       design@lists.freeswan.org, usagi@linux-ipv6.org
Subject: Re: [CryptoAPI-devel] Re: [Design] [PATCH] USAGI IPsec
References: <m3k7kpjt7c.wl@karaba.org>  <3DB41338.3070502@storm.ca> 
			<1035168066.4817.1.camel@rth.ninka.net> <1035185654.21824.11.camel@janus.txd.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> On Mon, 2002-10-21 at 04:41, David S. Miller wrote:
> > A completely new CryptoAPI subsystem has been implemented so that
> > full lists of page vectors can be passed into the ciphers, which is
> > necessary for a clean IPSEC implementation.
> 
> oh... nice to learn about your plans (so late) at all ;-)
> 
> well, it would be cool if you'd cooperate (or at least share
> information) with us (the official cryptoapi project ;-), as we're open
> for the design requirements of the next generation cryptoapi...

Official cryptoapi? Define official.

> ...otherwise this may render the kerneli.org/cryptoapi effort completely
> useless :-/ ...of course, if it's your long term goal to take the
> cryptoapi development away from kerneli.org, I'd like to know too ;-)

kerneli.org/cryptoapi _is_ useless joke for many needs. Fortunately other
people are able to see the limitations/sillyness of kerneli.org/cryptoapi:

1)  You are trying to replace link/insmod time overhead with runtime
    overhead + unnecessary bloat.
2)  No direct link access to low level cipher functions or higher level
    functions.
3)  No clean way to replace cipher code with processor type optimized
    assembler implementations.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

