Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTK3OfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 09:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbTK3OfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 09:35:19 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:43234 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S264916AbTK3OfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 09:35:15 -0500
Date: Sun, 30 Nov 2003 14:34:23 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andries Brouwer <aebr@win.tue.nl>
cc: Andrew Clausen <clausen@gnu.org>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <20031130132649.GC5738@win.tue.nl>
Message-ID: <Pine.LNX.4.58.0311301403130.2329@ua178d119.elisa.omakaista.fi>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129123451.GA5372@win.tue.nl> <20031129222722.GA505@gnu.org>
 <20031130003428.GA5465@win.tue.nl> <Pine.LNX.4.58.0311301210540.2329@ua178d119.elisa.omakaista.fi>
 <20031130132649.GC5738@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Nov 2003, Andries Brouwer wrote:
> >
> > Wrong:
> > 	http://support.microsoft.com/default.aspx?scid=kb;en-us;282191
> 
> "Wrong" - what a pessimism. 

Optimism ends up unbootable systems.

> Windows XP has no such restriction. If you explicitly ask Windows XP
> to use oldfashioned means, then of course that is your own choice.

It's not like that. People get boxes whatever way they were imaged, etc.  
Most don't know anything about the internals. And when they want to make it
dualboot with Linux, they might find they can't boot anymore.

Do you also really believe this oldfashioned means is the only way to end
up in problems because of partitioning tools change CHS units?
 
> if there is a partition table already and we are able to guess a geometry 
> from that, use that; otherwise [...]

OK, thanks, the problem is here. Maybe a warning could be added when the
geometry can't be guessed (if the warning isn't there already)?

	Szaka
