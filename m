Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289319AbSBJGaD>; Sun, 10 Feb 2002 01:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289323AbSBJG3y>; Sun, 10 Feb 2002 01:29:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:21261 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289319AbSBJG3l>;
	Sun, 10 Feb 2002 01:29:41 -0500
Date: Sun, 10 Feb 2002 04:29:31 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Miles Lane <miles@megapathdsl.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4-pre5 -- More drivers needing pci_alloc_consistent work?
Message-ID: <20020210062931.GE2677@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Miles Lane <miles@megapathdsl.net>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1013322074.28886.13.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013322074.28886.13.camel@turbulence.megapathdsl.net>
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 09, 2002 at 10:21:14PM -0800, Miles Lane escreveu:
> 
> drivers/net/appletalk/appletalk.o: In function `ipddp_xmit':
> drivers/net/appletalk/appletalk.o(.text+0x47): undefined reference to
> `atalk_find_dev_addr'
> drivers/net/appletalk/appletalk.o(.text+0x110): undefined reference to
> `aarp_send_ddp'
> drivers/net/appletalk/appletalk.o: In function `ipddp_create':
> drivers/net/appletalk/appletalk.o(.text+0x177): undefined reference to
> `atrtr_get_dev'

These are unrelated, I'll take a look tomorrow, its really strange as
atalk_find_dev_addr, for example, is exported...

- Arnaldo
