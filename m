Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129441AbRB0CEu>; Mon, 26 Feb 2001 21:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRB0CEl>; Mon, 26 Feb 2001 21:04:41 -0500
Received: from 2-113.cwb-adsl.telepar.net.br ([200.193.161.113]:11247 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129441AbRB0CEY>; Mon, 26 Feb 2001 21:04:24 -0500
Date: Mon, 26 Feb 2001 21:25:15 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, shingo@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fmvj18x_cs: don't reference skb after passing it to netif_rx
Message-ID: <20010226212515.P8692@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, shingo@flab.fujitsu.co.jp,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010226211403.N8692@conectiva.com.br> <3A9B0991.F34AF284@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A9B0991.F34AF284@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 26, 2001 at 08:57:37PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 26, 2001 at 08:57:37PM -0500, Jeff Garzik escreveu:
> Ditto...

thanks, as I said to Donald, I was in fast mode, so the driver maintainers
should take this into account and use my previous patches as a hint, I'm
considering this for the upcoming patches, if there's any more drivers that
are broken wrt this bug.

- Arnaldo
