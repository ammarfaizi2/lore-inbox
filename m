Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753082AbWKFN3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbWKFN3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbWKFN3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:29:10 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45726 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1753082AbWKFN3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:29:08 -0500
X-Sasl-enc: ZYXT9LN0YKNb0Entm4prU1QtEGu6d5jyFm9xiKNU5nk1 1162819748
Date: Mon, 6 Nov 2006 11:29:03 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061106132903.GA25257@khazad-dum.debian.net>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106092117.GB2175@elf.ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > it has no hotpluggable slots.

What about the internal mini PCI express slots (where the Intel 3945ABG
device and EVDO wwwan cards are plugged)?

Also, ThinkWiki lists this machine as one that has a CardBus slot.  A photo
I found also shows this cardbus slot, left side near palm rest, right above
a SD card slot.  According to Lenovo, it appears that this cardbus slot is
also a 34mm express card slot, which would account for a PCIe x1 hotplug bus
and a USB2 hotplug bus in addition to the PCI (pccard) hotplug bus.

And it is extremely likely that this notebook exposes either PCI or PCIe
lanes to the dock station.  Whether they implemented PCIe or PCI slots in
the dock is another story, of course...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
