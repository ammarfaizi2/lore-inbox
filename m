Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUKULTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUKULTj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUKULTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:19:39 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:47521 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261658AbUKULTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:19:35 -0500
Subject: Re: [PATCH 475] HP300 LANCE
From: Kars de Jong <jongk@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
References: <200410311003.i9VA3UMN009557@anakin.of.borg>
	 <20041101142245.GA28253@infradead.org>
	 <20041116084341.GA24484@infradead.org>
	 <20041116231248.5f61e489.akpm@osdl.org>
	 <Pine.GSO.4.61.0411211059500.19680@waterleaf.sonytel.be>
Content-Type: text/plain
Date: Sun, 21 Nov 2004 12:19:35 +0100
Message-Id: <1101035975.3278.2.camel@kars.perseus.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-21 at 11:01 +0100, Geert Uytterhoeven wrote:
> On Tue, 16 Nov 2004, Andrew Morton wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:
> > > > There's tons of leaks in the hplcance probing code, and it doesn't release
> > >  > he memory region on removal either.
> > >  > 
> > >  > Untested patch to fix those issues below:
> > > 
> > >  ping.
> > 
> > The fix needs a fix:
> 
> Indeed.
> 
> And you should remove the definitions of dio_resource_{start,len}(), as they're
> already defined in linux/dio.h.

Yes, that's what I wanted to write. Sorry I didn't respond sooner, my
harddisk died last week and I had to replace it first, which always
takes more time than you like...


Kind regards,

Kars.


