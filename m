Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSLAOfR>; Sun, 1 Dec 2002 09:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbSLAOfR>; Sun, 1 Dec 2002 09:35:17 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:44038 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261847AbSLAOfP>; Sun, 1 Dec 2002 09:35:15 -0500
Date: Sun, 1 Dec 2002 12:42:32 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCMCIA <dhinds@zen.stanford.edu>
Subject: Re: [BUGS 2.5.45]
Message-ID: <20021201144232.GC3098@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Nico Schottelius <schottelius@wdt.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	PCMCIA <dhinds@zen.stanford.edu>
References: <20021107090425.GA461@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107090425.GA461@schottelius.org>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 01, 2002 at 03:31:26PM +0100, Nico Schottelius escreveu:
> Hello again!

2.5.45 is too old, could you try 2.5.50 instead? Anyway, some comments:
 
> 1) As you'll all have noticed, the makefile for the build wants QT installed
> for a simple build process.

not if you use make menuconfig or make config, only for the GUI config frontend,
and there is people, AFAIK, working on a gtk+ frontend.
 
> 2) PCMCIA module ds.o cannot be loaded -> somehow the kernel denies that.

Perhaps related to Rusty's work on the in-kernel module loader
 
> 3) atimach64 console driver makes blank screen on 01:00.0 VGA compatible
> controller: ATI Technologies Inc 3D Rage P/M Mobilit= y AGP 2x (rev 64)

The fb code needs a merge with James Simmons tree, it seems to be planned to
happen soon.
 
- Arnaldo
