Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317353AbSFRHjE>; Tue, 18 Jun 2002 03:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSFRHjD>; Tue, 18 Jun 2002 03:39:03 -0400
Received: from pc1-camb4-0-cust108.cam.cable.ntl.com ([62.253.133.108]:9600
	"EHLO lain.perlfu.co.uk") by vger.kernel.org with ESMTP
	id <S317353AbSFRHjC>; Tue, 18 Jun 2002 03:39:02 -0400
Date: Tue, 18 Jun 2002 08:38:48 +0100 (BST)
From: Carl Ritson <critson@perlfu.co.uk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <netdev@oss.sgi.com>
Subject: Re: [PATCH][2.5.22] OOPS in tcp_v6_get_port
In-Reply-To: <20020618005735.GB1146@conectiva.com.br>
Message-ID: <Pine.LNX.4.44.0206180832040.1778-100000@lain.perlfu.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Arnaldo Carvalho de Melo wrote:

> Em Mon, Jun 17, 2002 at 02:33:19PM -0700, David S. Miller escreveu:
> > 
> > This is a known bug introduced by the struct sock splitup into
> > external per-protocol pieces done by Arnaldo de Melo.  He is working
> > on the proper fix, your proposed change will just paper over the real
> > bug.

I suspected something like that.

> Carl,
> 
> 	Can you try this patch?
> 
> - Arnaldo
> 
> --- orig/net/ipv6/tcp_ipv6.c    Sat May 25 23:13:56 2002
> +++ linux/net/ipv6/tcp_ipv6.c   Fri Jun 14 23:23:07 2002
> <diff snipped> 

This patch doesn't help, it produces exactly the same oops when decoded, I 
assume the newer patch you mention to Dave is the correct fix?

Thanks,
Carl

