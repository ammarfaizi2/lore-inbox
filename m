Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAEG5M>; Fri, 5 Jan 2001 01:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRAEG5D>; Fri, 5 Jan 2001 01:57:03 -0500
Received: from ns1.megapath.net ([216.200.176.4]:63492 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129324AbRAEG4p>;
	Fri, 5 Jan 2001 01:56:45 -0500
Message-ID: <3A556FE4.7030608@megapathdsl.net>
Date: Thu, 04 Jan 2001 22:55:32 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: Announce: modutils 2.4.0 is available
In-Reply-To: <14993.978663552@kao2.melbourne.sgi.com> <16062.978666989@kao2.melbourne.sgi.com> <20010104200333.A20175@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:

> Well, I'll be the one to fall on my sword...
> 
> This is probably my fault.  The matching code was pretty much broken for a
> non-trivial subset of usb devices.  I'd submitted the patch to Linus before
> the holdiays, but it was rejected for various reasons.  After some back and
> forth, Linus finally accepted it on about the 2st of the year.
> 
> It's pretty much the same patch (functionally) as I posted to the
> linux-usb-devel mailing list, which I presumed would inform the hotplugging
> people.

<snip>

We really do need a linux-hotplug mailing list.  Who would be able to
set up such a list on vger.kernel.org (or anywhere else that supports
maillist archives and has decent server loads)?  I've already floated
this idea once, but noone who can make this happen has volunteered.

Why we need this:

There are too many people working on hotplug issues in disjoint corners
of the kernel and utility community.  This work requires coordination
from the various bus developers (USB, SCSI, PCI, IrDA, Firewire,
Wireless, etc.) as well as folks working on the usermode scripts,
utilities and so forth.  There is also the need to sort out all the
PCMCIA/Cardbus issues having to do with migrating the installed base
over time to the new kernel drivers (yenta and friends).

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
