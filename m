Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSGICW3>; Mon, 8 Jul 2002 22:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317287AbSGICW2>; Mon, 8 Jul 2002 22:22:28 -0400
Received: from [200.203.199.90] ([200.203.199.90]:36624 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S317286AbSGICW2>; Mon, 8 Jul 2002 22:22:28 -0400
Date: Mon, 8 Jul 2002 23:24:59 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [patch] 2.5.25 net/core/Makefile
Message-ID: <20020709022458.GB2420@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>, Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org, davem@redhat.com
References: <20020709023628.A1697@suse.de> <23502.1026180810@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23502.1026180810@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 09, 2002 at 12:13:30PM +1000, Keith Owens escreveu:
> On Tue, 9 Jul 2002 02:36:28 +0200, 
> Dave Jones <davej@suse.de> wrote:
> >Same bug maybe, but triggered in different ways.
> >Note the CONFIG_NET change between your report and mine.
> 
> Sorry, missed that change the first time.
> 
> The problem is net/802/Makefile which includes p8022 for any of
> CONFIG_LLC, CONFIG_TR, CONFIG_IPX or CONFIG_ATALK.  p8022 calls

This will be moot when I remove p8022.c from the kernel (in fact all of
net/802), which I plan to do before 2.5 freeze 8)

- Arnaldo
