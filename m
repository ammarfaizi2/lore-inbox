Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUFKXpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUFKXpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 19:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUFKXpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 19:45:33 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:28150 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S264405AbUFKXpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 19:45:31 -0400
Subject: Re: [PPC]  2.6.7-rc3 IBM405EP kernel won't build without PCI
From: Aubin LaBrosse <arl8778@rit.edu>
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <40C9CC65.5030209@metaparadigm.com>
References: <1086930832.8686.50.camel@lhosts>
	 <40C9CC65.5030209@metaparadigm.com>
Content-Type: text/plain
Message-Id: <1086997505.15798.8.camel@lhosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 19:45:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2004-06-11 at 11:14, Michael Clark wrote:
> On 06/11/04 21:13, Aubin LaBrosse wrote:
> > Hello all,
> > 
> > I'm having a little fun with my first embedded system - it's an
> > Intrinsyc CerfCube, http://www.intrinsyc.com/products/cerfcube405EP/
> > 
> > basically it's got an ibm 405ep powerpc processor in it.  the thing
> > ships with a version of 2.4.21 but i've decided to take the newer
> > kernels for a spin on it.  except i can't compile unless i enable pci,
> > which is unnecessary for this thing since it has no pci bus.
> 
> Then why does it have a miniPCI connector?


so it does....I'm retarded. ;-)

Although I should still be able to build the kernel without pci support,
shouldn't I?

Where does the CONFIG_BIOS_FIXUP come from and is it necessary for a
device like this is I guess what I'm asking -  the code compiled in by
CONFIG_BIOS_FIXUP seems to depend on PCI being in but you can select it
without selecting PCI -  that's the underlying issue here I think.  I
assume I don't really need CONFIG_BIOS_FIXUP for this device (given the
name of the option, I would hope that this thing doesn't have a bios
that needs 'fixing
up') but I'm not even sure how to turn it off... and of course I'm only
guessing based on the error I got and the names of the things involved,
i haven't rolled up my sleeves and got into it yet..

-Aubin




> ~mc

