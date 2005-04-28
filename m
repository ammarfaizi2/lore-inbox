Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVD1WYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVD1WYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVD1WYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:24:03 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:17938 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262295AbVD1WXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:23:53 -0400
Date: Thu, 28 Apr 2005 19:23:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>,
       Regina Kodato <reginak@cyclades.com>, pc300@cyclades.com,
       Nenad Corbic <ncorbic@sangoma.com>, Henner Eisen <eis@baty.hanse.de>,
       linux-net@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanups in drivers/net/wan/ - kfree of NULL pointer is valid
Message-ID: <20050428222330.GI26945@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jesper Juhl <juhl-lkml@dif.dk>, netdev@oss.sgi.com,
	"David S. Miller" <davem@davemloft.net>,
	Regina Kodato <reginak@cyclades.com>, pc300@cyclades.com,
	Nenad Corbic <ncorbic@sangoma.com>,
	Henner Eisen <eis@baty.hanse.de>, linux-net@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0504290009310.2476@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504290009310.2476@dragon.hyggekrogen.localhost>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 29, 2005 at 12:22:22AM +0200, Jesper Juhl escreveu:
> kfree(0) is perfectly valid, checking pointers for NULL before calling 
> kfree() on them is redundant. The patch below cleans away a few such 
> redundant checks (and while I was around some of those bits I couldn't 
> stop myself from making a few tiny whitespace changes as well).


Acked-by: Arnaldo Carvalho de MElo <acme@ghostprotocols.net>
