Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTFGUsv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 16:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbTFGUsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 16:48:51 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:14606 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263558AbTFGUsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 16:48:50 -0400
Date: Sat, 7 Jun 2003 18:03:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: "David S. Miller" <davem@redhat.com>, KML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] compile fixes for recent changes to include/net/sock.h
Message-ID: <20030607210338.GE10340@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Martin Schlemmer <azarah@gentoo.org>,
	"David S. Miller" <davem@redhat.com>,
	KML <linux-kernel@vger.kernel.org>
References: <1055007025.6805.19.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055007025.6805.19.camel@nosferatu.lan>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 07, 2003 at 07:30:25PM +0200, Martin Schlemmer escreveu:
> Hi
> 
> This fixes compile failures due to recent changes in include/net/sock.h.
> Seems like a lot of struct sock's members had a 'sk_' appended, but
> changes to following was missed:
> 
>  drivers/net/ethertap.c
>  fs/smbfs/sock.c
>  fs/smbfs/proc.c

Thanks a lot, the smbfs one was already merged by Linus, somebody submitted
it some hours ago, the ethertap I'll push to DaveM today. 

Question: it is marked as OBSOLETE, should we ditch it now?

- Arnaldo
