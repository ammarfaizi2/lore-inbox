Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267565AbSKQTkn>; Sun, 17 Nov 2002 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbSKQTkn>; Sun, 17 Nov 2002 14:40:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267565AbSKQTkm>;
	Sun, 17 Nov 2002 14:40:42 -0500
Date: Sun, 17 Nov 2002 19:47:42 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [PATCH] change allow_write_access/deny_write_access prototype
Message-ID: <20021117194742.D7530@parcelfarce.linux.theplanet.co.uk>
References: <20021117193100.A6763@lst.de> <Pine.LNX.4.44.0211171036360.22525-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211171036360.22525-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 17, 2002 at 10:39:47AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 10:39:47AM -0800, Linus Torvalds wrote:
> Also, I'm going to stop applying the header file cleanups altogether 
> unless the people who send them to me check that things compile afterwards 
> a lot better.
> 
> Arnaldo has been helping a lot in fixing stuff up after the cleanups,
> thanks go to him. The last net.h/fs.h cleanup broke pcm_native.c, for
> example. 

I'm quite happy to test that my header cleanups don't break things --
but there are many things which don't currently compile anyway.  I try
to enable the things I think my changes will break, but I didn't spot
the isapnp one my pci_dev changes broke.  Could I ask that you update
defconfig with your .config again so we can be sure things don't break
_your_ build?

-- 
Revolutions do not require corporate support.
