Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131458AbRBWLZs>; Fri, 23 Feb 2001 06:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRBWLZi>; Fri, 23 Feb 2001 06:25:38 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:63470 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131458AbRBWLZ3>; Fri, 23 Feb 2001 06:25:29 -0500
Date: Fri, 23 Feb 2001 06:45:43 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andrey Panin <pazke@orbita.don.sitek.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/char/serial.c unchecked ioremap() calls
Message-ID: <20010223064543.C12444@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andrey Panin <pazke@orbita.don.sitek.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010223105359.A20170@orbita1.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010223105359.A20170@orbita1.ru>; from pazke@orbita.don.sitek.net on Fri, Feb 23, 2001 at 10:53:59AM +0300
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 23, 2001 at 10:53:59AM +0300, Andrey Panin escreveu:
> 
> Hi all,
> 
> 16x50 serial driver doesn't check ioremap() return value. 
> Atached patch should fix this it.

humm, have not checked, but it seems as if you don't release the previous
successful mappings on failure. Wipe out this message if I was too quick to
answer and this is not true. 8)

- Arnaldo
