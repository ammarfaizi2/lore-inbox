Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTAHVpN>; Wed, 8 Jan 2003 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267922AbTAHVpN>; Wed, 8 Jan 2003 16:45:13 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:15601 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S267906AbTAHVpM>; Wed, 8 Jan 2003 16:45:12 -0500
Date: Wed, 8 Jan 2003 22:53:53 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI code:  why need  outb (0x01, 0xCFB); ?
In-Reply-To: <CAD6B2D09F9@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1030108224859.11293F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Petr Vandrovec wrote:

> >  Fortunately that's not true.  Grab the relevant docs from: 
> > 'ftp://download.intel.com/support/chipsets/430nx/'.  The semantics of
> > 0xcf8, 0xcf9, 0xcfa and 0xcfb I/O ports when used as byte quantities is
> > explained there.  Note that 0xcf8 and 0xcfa are the way to get at the PCI
> > config space using conf2 accesses. 
> 
> Thanks, page 34 of 290479.pdf is exactly what I was looking for 
> (i.e. write 1 to 0xCFB to get PCI conf1, write 0 to get PCI conf2).
> Next time I'll complain immediately instead of spending time with
> browsing Intel website and google.

 Well, the download.intel.com docs are sometimes hard to get by.  There
are a few EISA and basic peripheral specs nearby, too.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

