Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281692AbRKQDnm>; Fri, 16 Nov 2001 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281698AbRKQDnd>; Fri, 16 Nov 2001 22:43:33 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:43532 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S281692AbRKQDna>;
	Fri, 16 Nov 2001 22:43:30 -0500
Date: Sat, 17 Nov 2001 00:21:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Tony Reed <Tony@TRLJC.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: It's me again ...
Message-ID: <20011117002104.C2043@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Tony Reed <Tony@TRLJC.COM>, linux-kernel@vger.kernel.org
In-Reply-To: <20011117015851.531B415B4A@kubrick.trljc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117015851.531B415B4A@kubrick.trljc.com>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 16, 2001 at 08:58:51PM -0500, Tony Reed escreveu:
> I've been building kernels since 2.2.15 or something, and I've never
> had problems before, so bear with me.
> 
> Where is "deacivate_page" defined?  Because, right at the end, I'm
> getting:

two options: delete the references to deactivate_page in
drivers/block/loop.c and rebuild your kernel or get the latest 2.4.15
prepatch that has this fixed.

- Arnaldo
