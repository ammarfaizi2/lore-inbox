Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132618AbRDKQNj>; Wed, 11 Apr 2001 12:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbRDKQN3>; Wed, 11 Apr 2001 12:13:29 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:55311 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132618AbRDKQNR>;
	Wed, 11 Apr 2001 12:13:17 -0400
Date: Wed, 11 Apr 2001 18:13:10 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Zdenek Kabelac <kabi@i.am>, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010411181310.C23974@pcep-jamie.cern.ch>
In-Reply-To: <3AD36409.6A956F3A@i.am> <Pine.GSO.3.96.1010411123424.2984D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010411123424.2984D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Apr 11, 2001 at 01:42:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Tue, 10 Apr 2001, Zdenek Kabelac wrote:
> 
> > I think it would be wrong if we could not add new very usable features
> > to the system just because some old hardware doesn't support it.
> 
>  s/old/crappy/ -- even old hardware can handle vsync IRQs fine.  E.g. TVGA
> 8900C. 

Think of the original 64k and 256k VGA cards.  I think some of those
didn't have an irq, but did have a way to read the progress of the
raster, which you could PLL to using timer interrupts.  Some video games
still look fine at 320x200 :-)

-- Jamie
