Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSI2W5Z>; Sun, 29 Sep 2002 18:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbSI2W5Y>; Sun, 29 Sep 2002 18:57:24 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:17669 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261836AbSI2W5Y>; Sun, 29 Sep 2002 18:57:24 -0400
Date: Sun, 29 Sep 2002 20:02:46 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] net/Config.in
Message-ID: <20020929230246.GE7028@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200209292258.g8TMwhH24099.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200209292258.g8TMwhH24099.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2002 at 12:58:43AM +0200, Andries.Brouwer@cwi.nl escreveu:
> I wanted to compile a kernel with Appletalk and couldn't find it.
> Upon examination of the source it turns out that since 2.5.32
> Appletalk is hiding behind "ANSI/IEEE 802.2 Data link layer".
> 
> This tiny patch will make life easier for others needing IPX
> or Appletalk.

Thanks, accepted, I'm pushing to DaveM in some moments, I also plan to
make IPX not require LLC to be built, using only EthernetII and 802.3
raw frames.

- Arnaldo
