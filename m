Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTI1VtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbTI1VtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:49:17 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:29445 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262776AbTI1VtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:49:16 -0400
Date: Sun, 28 Sep 2003 18:54:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928215427.GA1039@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>
References: <20030928200001.GC16921@wohnheim.fh-wedel.de> <Pine.LNX.4.33.0309282337190.16567-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309282337190.16567-100000@gans.physik3.uni-rostock.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 28, 2003 at 11:43:08PM +0200, Tim Schmielau escreveu:
> P.S.: My secret plan is to write a parser or hack sparse to do this for
> both #if and #else branches of conditionals at the same time. This
> however, is a big project, and I don't think of even _starting_ this
> before next year.

Well, I plan to work on a sparse tool that builds a ctags like database from
all the headers, removes the includes and puts the necessary ones, some
spurious cases can happen, as we don't have the best namespace in the world in
our includes, but hey, janitors could handle such a task, fixing the namespace
:-)

- Arnaldo
