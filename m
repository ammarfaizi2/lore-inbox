Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUH3DMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUH3DMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 23:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUH3DMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 23:12:54 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:36271 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266069AbUH3DMv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 23:12:51 -0400
Subject: Re: silent semantic changes with reiser4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Hans Reiser <reiser@namesys.com>, flx@msu.ru, Paul Jackson <pj@sgi.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	 <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
	 <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com>
	 <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
	 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
	 <41323751.5000607@namesys.com>
	 <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
	 <1093821430.8099.49.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org>
	 <1093830135.8099.181.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0408291919450.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093835526.8099.217.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 23:12:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 29/08/2004 klokka 22:31, skreiv Linus Torvalds:

> So together with the fact that nobody really _wants_ hardlinks to 
> directories, I think the right answer is "no". It's not a problem as
> long as the attributes streams are always tied to the file/directory
> they are attributes of - then the "directory link" is really just a
> file link, and can't cause any cycles.

Right.

> Do we have any servers that implement it? I think NFSv4 might be a good 
> test-case if so.

I believe Solaris Express already has an implementation, so I should
have at least one server implementation available in the basement.
So probably does Hummingbird, since their NFSv4 server runs on Windows.

CITI is working on the Linux code, but I'm not sure how far they've come
on the server side. I'll ask Bruce in the morning...

Cheers,
  Trond
