Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265471AbSJXOpz>; Thu, 24 Oct 2002 10:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbSJXOpv>; Thu, 24 Oct 2002 10:45:51 -0400
Received: from [134.117.69.100] ([134.117.69.100]:47633 "EHLO
	megaman.certainkey.com") by vger.kernel.org with ESMTP
	id <S265465AbSJXOpF>; Thu, 24 Oct 2002 10:45:05 -0400
Date: Thu, 24 Oct 2002 10:50:26 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Herbert Valerio Riedel <hvr@hvrlab.org>,
       "David S. Miller" <davem@rth.ninka.net>, Sandy Harris <sandy@storm.ca>,
       Mitsuru KANDA <mk@linux-ipv6.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, cryptoapi-devel@kerneli.org,
       design@lists.freeswan.org, usagi@linux-ipv6.org
Subject: Re: [CryptoAPI-devel] Re: [Design] [PATCH] USAGI IPsec
Message-ID: <20021024105026.C1170@certainkey.com>
References: <m3k7kpjt7c.wl@karaba.org> <3DB41338.3070502@storm.ca> <1035168066.4817.1.camel@rth.ninka.net> <1035185654.21824.11.camel@janus.txd.hvrlab.org> <3DB4DBC8.8647E32E@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB4DBC8.8647E32E@pp.inet.fi>; from jari.ruusu@pp.inet.fi on Tue, Oct 22, 2002 at 08:02:00AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:02:00AM +0300, Jari Ruusu wrote:
> kerneli.org/cryptoapi _is_ useless joke for many needs. Fortunately other
> people are able to see the limitations/sillyness of kerneli.org/cryptoapi:
> 
> 1)  You are trying to replace link/insmod time overhead with runtime
>     overhead + unnecessary bloat.
> 2)  No direct link access to low level cipher functions or higher level
>     functions.
> 3)  No clean way to replace cipher code with processor type optimized
>     assembler implementations.

Jari has a few points here.  But the "killer" functionalities are all there
IMHO.  Low-level assembler implementations are over-rated, again IMHO.  The
performance difference between C and ASM is at most 50%.  1ms vs 1.5 ms.
Even if you've got a large payload on the rare occation (>5MB) block ciphers
are quite fast for 95% of applications

JLC

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
C: 613.263.2983
