Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264512AbSIVUC1>; Sun, 22 Sep 2002 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264513AbSIVUC0>; Sun, 22 Sep 2002 16:02:26 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:45585 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264512AbSIVUC0>; Sun, 22 Sep 2002 16:02:26 -0400
Date: Sun, 22 Sep 2002 17:07:26 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jochen Friedrich <jochen@scram.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38
Message-ID: <20020922200726.GB20520@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jochen Friedrich <jochen@scram.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0209212130360.2433-100000@penguin.transmeta.com> <Pine.LNX.4.44.0209222201000.9027-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209222201000.9027-100000@alpha.bocc.de>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 22, 2002 at 10:02:10PM +0200, Jochen Friedrich escreveu:
> Hi,
> 
> build fails on Alpha:
> 
> make[2]: Entering directory `/home/src/linux-2.5.38/fs/partitions'
>   gcc -Wp,-MD,./.check.o.d -D__KERNEL__ -I/home/src/linux-2.5.38/include
> -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
> -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=check   -c
> -o check.o check.c
> check.c: In function `devfs_create_cdrom':
> check.c:365: `devfs_handle' undeclared (first use in this function)
> check.c:365: (Each undeclared identifier is reported only once

See previous posts, it fails on all archs. Linus already merged fixes, IIRC.

- Arnaldo
