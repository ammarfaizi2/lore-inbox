Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTIOQ5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTIOQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:57:22 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:46096 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261563AbTIOQ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:57:17 -0400
Date: Mon, 15 Sep 2003 13:59:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, rusty@rustcorp.com.au
Subject: Re: 2.6.0-test5-mm2
Message-ID: <20030915165928.GC1142@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, rusty@rustcorp.com.au
References: <20030914234843.20cea5b3.akpm@osdl.org> <1063636490.5588.10.camel@lorien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063636490.5588.10.camel@lorien>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 15, 2003 at 11:34:51AM -0300, Luiz Capitulino escreveu:
> #ifdef CONFIG_NETFILTER_DEBUG
>         nf_debug_ip_local_deliver(skb);
>         skb->nf_debug =3D 0;
                         ^^

Fixed in DaveM's tree, this kind of messages should be posted to the netfilter
and/or netdev mailing lists.

- Arnaldo
