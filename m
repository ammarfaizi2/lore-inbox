Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288767AbSADVVE>; Fri, 4 Jan 2002 16:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288769AbSADVU7>; Fri, 4 Jan 2002 16:20:59 -0500
Received: from air-1.osdl.org ([65.201.151.5]:24449 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S288767AbSADVUv>;
	Fri, 4 Jan 2002 16:20:51 -0500
Date: Fri, 4 Jan 2002 13:23:04 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020104155912.A23345@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201041320080.867-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> Dave Jones <davej@suse.de>:
> > > Waitaminute.  DMI is a *dying* standard?  What, if anything, is
> > > replacing it?
> >
> > ACPI
>
> OK.  So can I ask ACPI if the board has ISA slots?  Does it answer
> reliably?

The ACPI info comes from the BIOS. So, it's no more reliable than any
other BIOS, and probably less so than ones that do/did DMI, as there are
so many aspects to it.

I would suggest reading the ACPI spec at http://acpi.info and the Intel
implementation of it at

http://developer.intel.com/technology/IAPC/acpi/index.htm

for an idea of what it's supposed to do and what you can theoretically get
from it.

	-pat

