Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265722AbSJTA5c>; Sat, 19 Oct 2002 20:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265723AbSJTA5b>; Sat, 19 Oct 2002 20:57:31 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:59657 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265722AbSJTA5b>; Sat, 19 Oct 2002 20:57:31 -0400
Date: Sat, 19 Oct 2002 22:03:31 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
Message-ID: <20021020010331.GB15254@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021019233236.GI14009@conectiva.com.br> <20021019.165451.110952098.davem@redhat.com> <20021020000943.GL14009@conectiva.com.br> <20021019.173806.111570656.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019.173806.111570656.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 19, 2002 at 05:38:06PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Sat, 19 Oct 2002 21:09:43 -0300
>    
>    What about the CONFIG_IP_PROC_FS idea? Does it sounds reasonable or
>    is it utter crap? :-)
> 
> I don't know, it might be useful for someone.

Gigi Duru? :-)

> The question is if it is worth the effort ;)

We'll, if everybody stopped using net-tools and started using iproute2 the
world would be a better place and most of those proc stuff could just go away,
till this beautiful day the ones that use iproute2 and don't use any program
that touches /proc/net can have a smaller image to cram in their embedded toys.
Oh, and I'll use it for our installer disks as well 8)

- Arnaldo
