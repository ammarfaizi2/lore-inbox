Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbSI3EdV>; Mon, 30 Sep 2002 00:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261921AbSI3EdV>; Mon, 30 Sep 2002 00:33:21 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:26631 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261920AbSI3EdU>; Mon, 30 Sep 2002 00:33:20 -0400
Date: Mon, 30 Sep 2002 01:38:29 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, mingo@elte.hu,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       wli@holomorphy.com, kuznet@ms2.inr.ac.ru
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930043829.GG9920@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dipankar Sarma <dipankar@in.ibm.com>,
	"David S. Miller" <davem@redhat.com>, mingo@elte.hu,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	wli@holomorphy.com, kuznet@ms2.inr.ac.ru
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain> <20020930004559.A19071@in.ibm.com> <20020929.172022.23984844.davem@redhat.com> <20020930100317.A21939@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020930100317.A21939@in.ibm.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 30, 2002 at 10:03:17AM +0530, Dipankar Sarma escreveu:
> This is the list, I think,  by looking at packet_types -
 
Don't bother with snap, that one is just a dummy packet type, its not
even registered via dev_add_pack
>         802/psnap.c

I'm working on Appletalk, will be fixed after X.25, humm, in fact Appletalk
only uses SNAP on Ethernet, so it is only broken for ppptalk and ltalk, does
anybody still uses these later two?

>         appletalk/ddp.c

Ralf Bächle is working on ax25 (and its clients: ROSE and NETROM)
>         ax25/af_ax25.c

This doesn't exists anymore, what kernel are you looking at?
>         core/ext8022.c

Nobody working on this, as far as I know
>         econet/af_econet.c

Last I heard Alexey was working on fixing irda
>         irda/irsyms.c

I'm working on this one now
>         x25/af_x25.c

- Arnaldo
