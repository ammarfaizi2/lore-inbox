Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753034AbWKFTrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbWKFTrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752990AbWKFTrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:47:52 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34486 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752745AbWKFTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:47:51 -0500
X-Sasl-enc: qPcn5DsILRIOCapz7p5W7VcJIj1BndufXUbDHZsxsZvf 1162842471
Date: Mon, 6 Nov 2006 17:47:44 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Stefan Seyfried <seife@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061106194744.GA12458@khazad-dum.debian.net>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061106132903.GA25257@khazad-dum.debian.net> <20061106191351.GA1642@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106191351.GA1642@suse.de>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006, Stefan Seyfried wrote:
> On Mon, Nov 06, 2006 at 11:29:03AM -0200, Henrique de Moraes Holschuh wrote:
> > > > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > > > it has no hotpluggable slots.
> > 
> > What about the internal mini PCI express slots (where the Intel 3945ABG
> > device and EVDO wwwan cards are plugged)?
> 
> These are not in the media bay. I'd also guess that they are not
> hotpluggable.

They are hotplug buses.  But the buses themselves are always there (and not
hotplugged. i.e. the bus doesn't appear and disappear).  Whether they should
be bothering acpiphp, I don't know.  

You have a lot of buses that support hotplugging in the X60, and at least
one is certainly exported to the dock unless IBM/Lenovo changed completely
the way they make docks, which I very much doubt.  That was the information
I was trying to convey.   As I said, I don't know if *these* buses should be
bothering acpiphp or not.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
