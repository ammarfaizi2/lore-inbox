Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752503AbWKFTOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbWKFTOR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbWKFTOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:14:14 -0500
Received: from cantor2.suse.de ([195.135.220.15]:61121 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752470AbWKFTOK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:14:10 -0500
Date: Mon, 6 Nov 2006 20:13:51 +0100
From: Stefan Seyfried <seife@suse.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061106191351.GA1642@suse.de>
References: <20061101115618.GA1683@elf.ucw.cz> <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061106132903.GA25257@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061106132903.GA25257@khazad-dum.debian.net>
X-Operating-System: openSUSE 10.2 (i586) Beta1plus, Kernel 2.6.18.1-13-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2006 at 11:29:03AM -0200, Henrique de Moraes Holschuh wrote:
> > > > There is a bug here in that acpiphp shouldn't even be used on the X60 -
> > > > it has no hotpluggable slots.
> 
> What about the internal mini PCI express slots (where the Intel 3945ABG
> device and EVDO wwwan cards are plugged)?

These are not in the media bay. I'd also guess that they are not
hotpluggable.
 
> Also, ThinkWiki lists this machine as one that has a CardBus slot.  A photo

The cardbus slot is also not in the media bay and AFAIK not handled by
acpiphp.

-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
