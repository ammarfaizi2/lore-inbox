Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316780AbSFDU7Z>; Tue, 4 Jun 2002 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSFDU7Y>; Tue, 4 Jun 2002 16:59:24 -0400
Received: from fmr02.intel.com ([192.55.52.25]:54227 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S316780AbSFDU7W>; Tue, 4 Jun 2002 16:59:22 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7ED5@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>, Brad Hards <bhards@bigpond.net.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
Subject: RE: [patch] i386 "General Options" - begone [take 2]
Date: Tue, 4 Jun 2002 13:59:11 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "Power management options (ACPI, APM)", which also includes 
> software suspend.
> > "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> > "Executable file formats"

Brad,

This is a tough one because ACPI *is* power management but it is also
configuration. It is equivalent to such things as MPS table parsing, $PIR
parsing, PNPBIOS, as well as APM. The first two don't have CONFIG_ options
at the moment but they should at some point.

The only thing I can think of is a "Platform interface options" menu and
just throw all of the above in that. Any other ideas?

Regards -- Andy
