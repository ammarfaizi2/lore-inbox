Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129635AbRB0Jpt>; Tue, 27 Feb 2001 04:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129636AbRB0Jpk>; Tue, 27 Feb 2001 04:45:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15506 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129635AbRB0JpY>;
	Tue, 27 Feb 2001 04:45:24 -0500
Message-ID: <3A9B76D6.91376034@mandrakesoft.com>
Date: Tue, 27 Feb 2001 04:43:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH] via-rhine.c: don't reference skb after passing it tonetif_rx
In-Reply-To: <Pine.LNX.4.30.0102270939290.5264-100000@cola.teststation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
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

FWIW I sync up all my network driver patches (include most of the
last_rx/etc changes) with Alan first, and then ship them to Linus as
they are proven stable.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
