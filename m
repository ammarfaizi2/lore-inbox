Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRDQBgF>; Mon, 16 Apr 2001 21:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132502AbRDQBfz>; Mon, 16 Apr 2001 21:35:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11528 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132500AbRDQBfq>;
	Mon, 16 Apr 2001 21:35:46 -0400
Date: Mon, 16 Apr 2001 19:37:20 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ksi@cyberbills.com (Sergey Kubushin), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac7
Message-ID: <20010416193720.G31698@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	ksi@cyberbills.com (Sergey Kubushin), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0104160910330.20561-100000@nomad.cyberbills.com> <E14pBgV-0000Vy-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14pBgV-0000Vy-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Apr 16, 2001 at 05:16:58PM +0100
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 16, 2001 at 05:16:58PM +0100, Alan Cox escreveu:
> > gcc -D__KERNEL__ -I/tmp/build-kernel/usr/src/linux-2.4.3ac7/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /tmp/build-kernel/usr/src/linux-2.4.3ac7/include/linux/modversions.h   -c -o cycx_x25.o cycx_x25.c
> > cycx_x25.c: In function `new_if':
> > cycx_x25.c:364: structure has no member named `port'
> 
> Fixed in my working tree. The Sangoma patch Linus merged accidentally backed out
> support for a competing product.

Thanks, I'm to busy now, but I would submit a patch getting those fields
back in wanrouter.h.

- Arnaldo
