Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSI0B3p>; Thu, 26 Sep 2002 21:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbSI0B3p>; Thu, 26 Sep 2002 21:29:45 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:24586 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261597AbSI0B3o>; Thu, 26 Sep 2002 21:29:44 -0400
Date: Thu, 26 Sep 2002 22:34:57 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/4] increase traffic on linux-kernel
Message-ID: <20020927013457.GQ19921@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <3D928864.23666D93@digeo.com> <an0cd5$262$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an0cd5$262$1@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 27, 2002 at 01:31:17AM +0000, Linus Torvalds escreveu:
> In article <3D928864.23666D93@digeo.com>,
> Andrew Morton  <akpm@digeo.com> wrote:

> >Infrastructure to detect sleep-inside-spinlock bugs.  Really only
> >useful if compiled with CONFIG_PREEMPT=y.  It prints out a whiny
> >message and a stack backtrace if someone calls a function which might
> >sleep from within an atomic region.
> 
> This is in my BK tree now, along with Ingo's symbolic backtraces, which
> makes it possibly less tedious to read the output. 

Wheee! Thanks a LOT for merging both. We'll have lots of fun with these ones
while saving the old network protocols, that have lots of cases where we can
see problems even without these tools, imagine with them in place 8)

- Arnaldo
