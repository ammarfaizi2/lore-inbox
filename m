Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbTCGXth>; Fri, 7 Mar 2003 18:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261931AbTCGXtb>; Fri, 7 Mar 2003 18:49:31 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10930
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261927AbTCGXsJ>; Fri, 7 Mar 2003 18:48:09 -0500
Subject: Re: [PATCH] register_blkdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Joel Becker <Joel.Becker@oracle.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030307225710.A18005@infradead.org>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	 <20030307193644.A14196@infradead.org>
	 <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com>
	 <20030307225517.GF2835@ca-server1.us.oracle.com>
	 <20030307225710.A18005@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047085445.24208.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 01:04:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 22:57, Christoph Hellwig wrote:
> > 	This is essential.  There are installations using >1000 disks
> 
> and?  we still have tons of free block majors..

You can throw 65536 volumes onto a single S/390 box. Going to 32bit
dev_t sorts out a lot of the problems people have with major numbering
and allocation of devices sensibly, it means I can finally get the
space to do stuff like supporting session mounting on cd too

