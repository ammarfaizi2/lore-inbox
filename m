Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRB0SDx>; Tue, 27 Feb 2001 13:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRB0SDn>; Tue, 27 Feb 2001 13:03:43 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:31984 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129686AbRB0SDg>; Tue, 27 Feb 2001 13:03:36 -0500
Date: Tue, 27 Feb 2001 13:24:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Urban Widmark <urban@teststation.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH] via-rhine.c: don't reference skb after passing it to netif_rx
Message-ID: <20010227132436.B11171@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Urban Widmark <urban@teststation.com>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20010226211536.O8692@conectiva.com.br> <Pine.LNX.4.30.0102270939290.5264-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <Pine.LNX.4.30.0102270939290.5264-100000@cola.teststation.com>; from urban@teststation.com on Tue, Feb 27, 2001 at 10:07:07AM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 27, 2001 at 10:07:07AM +0100, Urban Widmark escreveu:
> On Mon, 26 Feb 2001, Arnaldo Carvalho de Melo wrote:
> 
> > thanks, I'll take that into account for the remaining ones and this should
> > be checked by the driver authors for the ones I've already sent.
> 
> The pkt_len variant is already in 2.4.1-ac15 and probably before that
> (changed by Manfred Spraul back in ac4?).
> 
> Perhaps you should run through the drivers in -acX instead/also?
> (too late now I guess :)

well, I think that some of the patches will apply cleanly to both 2.4.2
stock and 2.4.2-acLATEST, or at least sound as a hint to driver
maintainers. I'll wait for the next ac patch and look again.

- Arnaldo
