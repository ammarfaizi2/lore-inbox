Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970791-11449>; Mon, 9 Mar 1998 02:36:38 -0500
Received: from warthog.nexor.co.uk ([128.243.9.237]:2132 "EHLO nexor.co.uk" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <970814-11449>; Mon, 9 Mar 1998 02:36:11 -0500
To: "William R. Kerr" <bilker@SpiritOne.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: cPCI Hot Swap for Linux (system-level issues) 
In-reply-to: Your message of "Wed, 04 Mar 1998 22:53:47 PST."             <199803050653.WAA32072@ridge.spiritone.com> 
Date: Mon, 09 Mar 1998 08:57:05 +0000
From: David Howells <dwh@nexor.co.uk>
Message-Id: <19980309073624Z970814-11449+4748@vger.rutgers.edu>
X-Envid: [/PRMD=NEXOR/ADMD= /C=GB/;nexor.co.uk:289350:980309085725]
Sender: owner-linux-kernel@vger.rutgers.edu

> All issues of this type can be resolved, and I would urge people with more
> recent experience in kernel workings than I to begin drafting some plans for
> how this could be cleanly laid out.  The goal would be write a portable "bus
> driver" and a set of clearly specified conventions that writers of device
> drivers could follow so that drivers could be written that would work both
> with normal PCI implementations of the device as well as with Hot Swap cPCI
> implementations.

My configuration manager was written with this sort of thing in mind (though I
was thinking in terms of PnP-BIOS hot-swap at the time)... It uses automatic
rebinding of resources (with driver notification) as its method of conflict
resolution.

However, I haven't gone through and modified the majority of the vast
collection of drivers that Linux has available, as (1) I can't test most of
them, and (2) I would have to re-modify them every time I ported to a new
kernel version.

See:
	http://lucifer.hemmet.s-hem.chalmers.se/~dwh

David Howells

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
