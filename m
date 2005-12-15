Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422698AbVLOLrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422698AbVLOLrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 06:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbVLOLrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 06:47:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41873 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422698AbVLOLrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 06:47:39 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: Arjan van de Ven <arjan@infradead.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Sridhar Samudrala <sri@us.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <43A155AE.4050105@superbug.co.uk>
References: <Pine.LNX.4.58.0512140042280.31720@w-sridhar.beaverton.ibm.com>
	 <9a8748490512141216x7e25ca2cucb675f11f0c9d913@mail.gmail.com>
	 <43A08546.8040708@superbug.co.uk> <20051215015456.GC23393@gaz.sfgoth.com>
	 <43A155AE.4050105@superbug.co.uk>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 12:47:28 +0100
Message-Id: <1134647248.16486.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> You are using the wrong hammer to crack your nut.
> You should instead approach your problem of why the ARP entry gets lost.
> For example, you could give as critical priority to your TCP session, 
> but that still won't cure your ARP problem.
> I would suggest that the best way to cure your arp problem, is to 
> increase the time between arp cache refreshes.

or turn it around entirely: all traffic is considered important
unless... and have a bunch of non-critical sockets (like http requests)
be marked non-critical.


