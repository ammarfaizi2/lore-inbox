Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262156AbREQAKm>; Wed, 16 May 2001 20:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbREQAKX>; Wed, 16 May 2001 20:10:23 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:31176 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262156AbREQAKS>; Wed, 16 May 2001 20:10:18 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE2A7@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'H. Peter Anvin'" <hpa@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: RE: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 17:09:06 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa wrote:
> 
> Alan Cox wrote:
> > 
> > > Are FireWire (and USB) disks always detected in the same 
> > > order? Or does it
> > > behave like ADB, where you never know which 
> > > mouse/keyboard is which mouse/keyboard?
> > 
> > USB disks are required (haha etc) to have serial numbers. 
> > Firewire similarly has unique disk identifiers.

Bulk-only USB storage is required to have serial numbers.
E.g., Zip drives, probably USB hard drives and CDs.
Drives that use CBI (control/bulk/interrupt) transport (mostly
floppies) are not required to have serial numbers.
(Cost thing, of course.)

> How about for other device classes?

Mice?  no way.  Keyboards?  nope.
Webcams?  nope.
Printers?  optional.
Audio?  no.
Communication?  not mentioned in the spec.
Hub?  not mentioned in the spec.

~Randy

