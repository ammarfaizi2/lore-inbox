Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWEWPAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWEWPAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWEWPAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:00:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19093 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932232AbWEWPAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:00:51 -0400
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Herman Elfrink <herman.elfrink@ti-wmc.nl>
In-Reply-To: <20060523145549.GA22749@harddisk-recovery.com>
References: <44731733.7000204@ti-wmc.nl>
	 <1148395738.25255.68.camel@localhost.localdomain>
	 <44731F2C.2010109@ti-wmc.nl> <20060523145549.GA22749@harddisk-recovery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 May 2006 16:14:27 +0100
Message-Id: <1148397268.25255.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-23 at 16:55 +0200, Erik Mouw wrote:
> > >Ethernet protocol number I assume you mean. If so this at least used to
> > >be handled by the IEEE, along with ethernet mac address ranges.
> > >
> > 
> > Yes ethernet protocol (it's below IP level), I didn't realise that IEEE 
> > also handled the portnumbers. I'll check the ieee website to see how it 
> > works, tnx!
> 
> IEEE doesn't handle port numbers. Port numbers are for whatever is
> layered on top of ethernet, so you need to register those with the
> appropriate authorities (IANA for IP).

No no no

There are several sets of numbers here

Each ethernet DIX frame has a "protocol" (its the bits used for length
in 802.*). IEEE at least used to handle the assignment of those. On top
of that you have IP, IPX, etc with their own numbering agency.

As he said "ethernet protocol (it's below IP level)", those are the
protocol numbering bodies he wants, or to whomever it was delegated.

Alan

