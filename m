Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287328AbRL3EEb>; Sat, 29 Dec 2001 23:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287332AbRL3EEW>; Sat, 29 Dec 2001 23:04:22 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:43524 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287328AbRL3EEH>;
	Sat, 29 Dec 2001 23:04:07 -0500
Date: Sun, 30 Dec 2001 02:03:58 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Janitor Project 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [ANNOUNCE] include dependency graph script
Message-ID: <20011230020358.E2856@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Janitor Project <kernel-janitor-discuss@lists.sourceforge.net>
In-Reply-To: <20011230013033.A2856@conectiva.com.br> <23616.1009684530@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23616.1009684530@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 30, 2001 at 02:55:30PM +1100, Keith Owens escreveu:
> On Sun, 30 Dec 2001 01:30:33 -0200, 
> Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:
> >	For the people that like me, Daniel Phillips and Manfred Spraul are
> >working on pruning the include dependencies in the kernel sources I made a
> >simple script to make a graphviz file to plot the dependencies in a nice
> >graphic, its available at:
> >
> >http://www.kernel.org/pub/linux/kernel/people/acme/hviz
> 
> I suggest that you prune linux/config.h and autoconf.h from all graphs.
> The dependency system does not depend directly on those files, instead
> it depends on individual config options.
> 
> It makes more sense to list the individual config options that an
> include file depends on, see the code in scripts/mkdep.c.  Even then it
> would be better to suppress the config options by default and only list
> them when requested.

Thanks for the comments, this was a quick hack, I'll probably rewrite it in
python gleaning code from a tool we have here in Conectiva to prune/analise
the RPM packages dependency hell.

- Arnaldo
