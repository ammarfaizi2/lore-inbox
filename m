Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267718AbRGUQgS>; Sat, 21 Jul 2001 12:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267727AbRGUQgI>; Sat, 21 Jul 2001 12:36:08 -0400
Received: from 3-118.ctame701-2.telepar.net.br ([200.181.171.118]:50937 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S267718AbRGUQfy>; Sat, 21 Jul 2001 12:35:54 -0400
Date: Sat, 21 Jul 2001 13:36:05 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "peter k." <spam-goes-to-dev-null@gmx.net>
Cc: "David Schwartz" <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Message-ID: <20010721133605.C3667@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"peter k." <spam-goes-to-dev-null@gmx.net>,
	"David Schwartz" <davids@webmaster.com>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMCECBCKAA.davids@webmaster.com> <002f01c11202$60f22100$c20e9c3e@host1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <002f01c11202$60f22100$c20e9c3e@host1>; from spam-goes-to-dev-null@gmx.net on Sat, Jul 21, 2001 at 06:29:37PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Em Sat, Jul 21, 2001 at 06:29:37PM +0200, peter k. escreveu:
> 
> > > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0"
> > > is started
> > > automatically when booting (by the kernel obviously)? why? what
> > > does it do?
> > > i didnt find any useful information on it in linuxdoc / linux-kernel
> > > archives
> > It's the kernel soft IRQ daemon. It provides a context from which to
> > execute 'slow' code that was triggered by an interrupt. There will be one
> > per CPU.
> 
> why wasnt it run in previous kernels? im just wondering why it suddenly

because previous kernels had problems that Andrea's approach fixes? Read
the archives for the thread about it.

- Arnaldo
