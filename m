Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264408AbTCXTEu>; Mon, 24 Mar 2003 14:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264406AbTCXTEs>; Mon, 24 Mar 2003 14:04:48 -0500
Received: from verein.lst.de ([212.34.181.86]:3345 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S264405AbTCXTEr>;
	Mon, 24 Mar 2003 14:04:47 -0500
Date: Mon, 24 Mar 2003 20:15:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] intelfb fixes
Message-ID: <20030324201546.A11416@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fbdev-devel@lists.sourceforge.net
References: <20030321193703.A12179@lst.de> <1048537227.25652.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048537227.25652.33.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 24, 2003 at 08:20:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 08:20:27PM +0000, Alan Cox wrote:
> On Fri, 2003-03-21 at 18:37, Christoph Hellwig wrote:
> > It looks like someone is trying to make the kernel looling as messy
> > as XFree..
> > 
> > Remove the silly symlinking rules from the intelfb makefile and remove
> > one of the copies of the private copy of modedb in intelfb.  Maybe
> > someone who actually has the hardware could fix it to properly use
> > modedb directly.
> 
> No longer compiles with that change

It _does_ compile (after actually adding intelfb to Config.in) in
Marcelo's tree.  You're probably hit by the symlink braindamage in
the original driver tarball..

