Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265732AbSKIOop>; Sat, 9 Nov 2002 09:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265814AbSKIOop>; Sat, 9 Nov 2002 09:44:45 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:53512 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265732AbSKIOoo>; Sat, 9 Nov 2002 09:44:44 -0500
Date: Sat, 9 Nov 2002 14:51:25 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>
Subject: Re: [PATCH] SCSI on non-ISA systems
Message-ID: <20021109145125.A13499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Russell King <rmk@arm.linux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Rusty Trivial Russell <trivial@rustcorp.com.au>
References: <20021108135742.A22790@flint.arm.linux.org.uk> <Pine.GSO.4.21.0211081522050.23267-100000@vervain.sonytel.be> <20021108144234.A24114@flint.arm.linux.org.uk> <1036772421.16651.10.camel@irongate.swansea.linux.org.uk> <20021109005344.A26065@infradead.org> <1036847585.20393.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1036847585.20393.8.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Nov 09, 2002 at 01:13:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 09, 2002 at 01:13:05PM +0000, Alan Cox wrote:
> On Sat, 2002-11-09 at 00:53, Christoph Hellwig wrote:
> > No.  I restructured the BHA interfaces to get rid of ->detect and
> > ->release.  Makeing it mandatory is a step backwards.  Not having a
> > default fallback is a good idea, though.
> 
> That IMHO is not a 2.6 change

My restructuring?  It's already in 2.5..

