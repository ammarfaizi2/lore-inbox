Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290583AbSARCCx>; Thu, 17 Jan 2002 21:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290584AbSARCCn>; Thu, 17 Jan 2002 21:02:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28176 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290583AbSARCCd>;
	Thu, 17 Jan 2002 21:02:33 -0500
Date: Fri, 18 Jan 2002 00:02:31 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Guillaume Boissiere" <boissiere@mediaone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 17, 2001
Message-ID: <20020118020231.GB6208@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Guillaume Boissiere" <boissiere@mediaone.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C463337.24593.CD1AD57@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C463337.24593.CD1AD57@localhost>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2002 at 02:13:11AM -0500, Guillaume Boissiere escreveu:
> o Started  More complete NetBEUI and 802.2 net stacks   (Alnaldo C de M)

s/Alnaldo/Arnaldo/g

8)

Good work! I must add:

o Ready  Per network protocol slabcache and sock.h cleanup (Arnaldo)
o WIP    Per fs slabcache and fs.h cleanup                 (Daniel/jgarzik)

About the 802.2 net stack: its mostly ready, its being used by the
linux-sna folks but I've stopped work on it for a while (Jay is also busy
with other things right now) to work on the sock cleanup and on a wireless
driver (stopped now for a while, will merge other drivers available for the
planet wirefree pcmcia driver) and to help in the BIO scsi drivers conversion
front.

About the NetBEUI stack, it mostly works but its not SMP safe and its still
not in a good shape IMHO).

I'll probably be submitting the per network protocol slabcache/sock.h
cleanup to DaveM RSN.

- Arnaldo
