Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261992AbTCHCKU>; Fri, 7 Mar 2003 21:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbTCHCKU>; Fri, 7 Mar 2003 21:10:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49676 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261992AbTCHCKT>; Fri, 7 Mar 2003 21:10:19 -0500
Date: Fri, 7 Mar 2003 18:18:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Joel Becker <Joel.Becker@oracle.com>
cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@digeo.com>, <cherry@osdl.org>, <rddunlap@osdl.org>,
       <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] register_blkdev
In-Reply-To: <20030308021505.GH2835@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0303071816270.2204-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Joel Becker wrote:
> 
> 	That said, however /dev is populated, we need the dev_t space to
> represent the devices :-)

And realize that these things are often limited by on-disk / wire
representations. Some of which are easier to fix than others (ie, think 
about NFS servers running old versions of Linux).

		Linus

