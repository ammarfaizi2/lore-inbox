Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTBCPtC>; Mon, 3 Feb 2003 10:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266736AbTBCPtC>; Mon, 3 Feb 2003 10:49:02 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:23313 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266638AbTBCPtA>; Mon, 3 Feb 2003 10:49:00 -0500
Date: Mon, 3 Feb 2003 13:58:23 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Message-ID: <20030203155822.GC8298@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1044285222.2396.14.camel@gregs> <1044285758.2527.8.camel@laptop.fenrus.com> <1044286926.2396.28.camel@gregs> <20030203155225.A5968@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203155225.A5968@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 03, 2003 at 03:52:25PM +0000, Russell King escreveu:
> On Mon, Feb 03, 2003 at 03:42:06PM +0000, Grzegorz Jaskiewicz wrote:
> > > and that
> > >         printk("<1>%d\n", TimerIntrpt);
> > > you shouldn't use <1> in printk strings ever.
> > <1>gives me messages on screen on my box, thats why.

Also look at /proc/sys/kernel/printk and
Documentation/sysctl/kernel.txt
 
- Arnaldo
