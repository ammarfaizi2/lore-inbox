Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbTCGX6L>; Fri, 7 Mar 2003 18:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbTCGX6K>; Fri, 7 Mar 2003 18:58:10 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16818
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261954AbTCGX6F>; Fri, 7 Mar 2003 18:58:05 -0500
Subject: Re: [PATCH] register_blkdev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20030307234541.GG21315@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	 <20030307193644.A14196@infradead.org>
	 <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com>
	 <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047086062.24215.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 08 Mar 2003 01:14:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 23:45, Greg KH wrote:
> I would too.  Andries's patches look like the right thing to do, so far
> as I've seen.  But there are larger, social issues, that probably need
> to be answered first (like convincing Linus and others that this is
> really needed).
> 
> > > But if it is, a lot of character drivers need to be audited...
> > 
> > What has to be done there?
> 
> I haven't seen a patch yet, to really know what will be necessary.  But
> for one, a lot of drivers have static arrays where they just "know" that
> there can't be more than 256 minors under their control.

So we need a maxminors flag in the register for 2.6 I guess ?



