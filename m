Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbSJPGnq>; Wed, 16 Oct 2002 02:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264933AbSJPGnq>; Wed, 16 Oct 2002 02:43:46 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:15888 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264932AbSJPGnk>; Wed, 16 Oct 2002 02:43:40 -0400
Date: Wed, 16 Oct 2002 03:49:32 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: udp seq_file support: produce only one record per seq_show
Message-ID: <20021016064932.GA2543@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org
References: <20021016062449.GC1352@conectiva.com.br> <20021015.233914.68256249.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015.233914.68256249.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 15, 2002 at 11:39:14PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Wed, 16 Oct 2002 03:24:49 -0300
>    
>    master.kernel.org:/home/acme/BK/net-2.5
> 
> Pulled.
> 
> Two notes:
> 
> 1) ARP and FIB hacks need similar treatment

I'm working on that.

> 2) I don't think it's so nice to snprintf() onto the
>    stack and then seq_printf() that in fib_node_seq_show.
> 
>    You should be able to keep the line within it's
>    limit length just by specifying lengths to the integer
>    formats.

Will fix this.
