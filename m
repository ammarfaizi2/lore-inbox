Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSKTT6W>; Wed, 20 Nov 2002 14:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSKTT6W>; Wed, 20 Nov 2002 14:58:22 -0500
Received: from bitmover.com ([192.132.92.2]:51407 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262314AbSKTT6U>;
	Wed, 20 Nov 2002 14:58:20 -0500
Date: Wed, 20 Nov 2002 12:05:18 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Andre Hedrick <andre@linux-ide.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Mark Mielke <mark@mark.mielke.cc>, Rik van Riel <riel@conectiva.com.br>,
       David McIlwraith <quack@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
Message-ID: <20021120120518.L13503@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@digeo.com>, Cort Dougan <cort@fsmlabs.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Xavier Bestel <xavier.bestel@free.fr>,
	Mark Mielke <mark@mark.mielke.cc>,
	Rik van Riel <riel@conectiva.com.br>,
	David McIlwraith <quack@bigpond.net.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021120123145.B17249@duath.fsmlabs.com> <Pine.LNX.4.10.10211201137110.3892-100000@master.linux-ide.org> <20021120124405.C17249@duath.fsmlabs.com> <3DDBEA20.C8E1DC2C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DDBEA20.C8E1DC2C@digeo.com>; from akpm@digeo.com on Wed, Nov 20, 2002 at 12:01:36PM -0800
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make it ignore BK and/or SCCS files.

> open(FIND, "find . -name \*.[ch] |") || die "couldn't run find on *.[ch]\n";
> while ($f = <FIND>) {
> 	chop $f;
	next if m|SCCS/s\.|;
	next if m|BitKeeper/|;


-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
