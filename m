Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311866AbSCTR2Z>; Wed, 20 Mar 2002 12:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSCTR2P>; Wed, 20 Mar 2002 12:28:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:65042 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S311866AbSCTR1z>;
	Wed, 20 Mar 2002 12:27:55 -0500
Date: Wed, 20 Mar 2002 14:35:46 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: 2.2.19-pre3-ac3 compile failure
Message-ID: <20020320173546.GX20602@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	linux-kernel@vger.kernel.org, Alan.Cox@linux.org
In-Reply-To: <200203201617.g2KGHDkZ009635@tigger.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 20, 2002 at 12:17:13PM -0400, Horst von Brand escreveu:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE  -DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c
> pppoe.c: In function `pppoe_flush_dev':
> pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)
> pppoe.c:282: (Each undeclared identifier is reported only once
> pppoe.c:282: for each function it appears in.)
> pppoe.c: In function `pppoe_disc_rcv':
> pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)
> pppoe.c: In function `pppoe_ioctl':
> pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)
> make[2]: *** [pppoe.o] Error 1

Interesting, this was reported for 2.4.18 or 2.4.19-pre-early, IIRC the
fixes are there already, maybe Alan has left this unmerged accidentaly
