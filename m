Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSI3AZq>; Sun, 29 Sep 2002 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSI3AZq>; Sun, 29 Sep 2002 20:25:46 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:56581 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261857AbSI3AZb>; Sun, 29 Sep 2002 20:25:31 -0400
Date: Sun, 29 Sep 2002 21:05:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] net/Config.in
Message-ID: <20020930000537.GG7028@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200209300001.g8U01iY27223.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200209300001.g8U01iY27223.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2002 at 02:01:44AM +0200, Andries.Brouwer@cwi.nl escreveu:
> > Thanks, accepted, I'm pushing to DaveM in some moments ...
> 
> OK, that was the configuration part.
> The kernel oopses at boot time in llc_sap_find().
> I seem to recall that I saw some such oopses on lk
> but didnt pay attention. Has this been fixed already?

Humm, 2.5.39? It is compiled statically, isn't it? I'm working exclusively
with modules up to now, I'll try to reproduce and fix it :-\

- Arnaldo
