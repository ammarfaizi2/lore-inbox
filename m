Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSFDWMl>; Tue, 4 Jun 2002 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316884AbSFDWLO>; Tue, 4 Jun 2002 18:11:14 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59131 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316878AbSFDWKc>; Tue, 4 Jun 2002 18:10:32 -0400
Subject: RE: [patch] i386 "General Options" - begone [take 2]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Dave Jones'" <davej@suse.de>, "'Pavel Machek'" <pavel@suse.cz>,
        Brad Hards <bhards@bigpond.net.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@rustcorp.com.au
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7ED8@orsmsx111.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 00:16:12 +0100
Message-Id: <1023232572.11340.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 22:58, Grover, Andrew wrote:
> So, let's assume in the very near future it becomes possible to compile a
> kernel without MPS or $PIR support. Where should those config options go?
> These, in addition to pnpbios, are also unneeded with ACPI. That is why I
> was advocating the more general "Platform interface options" menu, so we
> could have *one* place to config these and ACPI in or out, instead of having
> the many different platform interface options in different logical areas.

Hardware Discovery using
	PnpBIOS
	ISAPnP
	MCA
	PCI
	ACPI

IRQ Routing using
	PCI BIOS
	$PIR
	MP 1.x
	ACPI

Power Management using
	CPU idling instructions
	APM
	Direct power management
	ACPI


There are all sorts of combinations that make sense, and trying to make
them all map around ACPI makes no sense, especially once you hit non x86
platforms where the mentality is quite different about what is
associated

	
