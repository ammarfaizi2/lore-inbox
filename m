Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277363AbRJOJqe>; Mon, 15 Oct 2001 05:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277364AbRJOJqZ>; Mon, 15 Oct 2001 05:46:25 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:14610 "EHLO
	smtp.alcove-fr") by vger.kernel.org with ESMTP id <S277363AbRJOJqN>;
	Mon, 15 Oct 2001 05:46:13 -0400
Date: Mon, 15 Oct 2001 11:45:56 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Jurgen Botz <jurgen@botz.org>
Cc: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org,
        ion@cs.columbia.edu, sduchene@mindspring.com
Subject: Re: [PATCH] PnP BIOS -- bugfix; update devlist on setpnp
Message-ID: <20011015114556.F4523@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <jdthood@mail.com> <1002987648.764.23.camel@thanatos> <200110150637.f9F6bek14014@nova.botz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200110150637.f9F6bek14014@nova.botz.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 11:37:39PM -0700, Jurgen Botz wrote:

> Thomas Hood wrote:
> > Okay, here's a new major patch to the PnP BIOS driver
> > which needs some testing before it's integrated.
> >[...] 
> > Vaio users: Please make sure that this doesn't oops.
> 
> Patched against 2.4.12-ac1, it works and doesn't oops my
> VAIO PCG-N505VE.  

Same for me (against a 2.4.10-ac12), on a VAIO PCG-C1VE.

Relevant (maybe) output:

...
Sony Vaio laptop detected.
BIOS strings suggest APM reports battery life in minutes and wrong byte order.
PCI: PCI BIOS revision 2.10 entry at 0xfd98e, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 9 for device 00:08.0
PCI: Sharing IRQ 9 with 00:07.2
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f8120.
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xb25f, dseg 0x400.
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver.
PnPBIOS: PNP0c02: 0xfff80000-0xffffffff was already reserved
PnPBIOS: PNP0c02: 0xfff7f600-0xfff7ffff was already reserved
PnPBIOS: PNP0c02: 0x398-0x399 has been reserved
PnPBIOS: PNP0c02: 0x4d0-0x4d1 has been reserved
PnPBIOS: PNP0c02: 0x8000-0x804f was already reserved
PnPBIOS: PNP0c02: 0x1040-0x104f has been reserved
PnPBIOS: PNP0c01: 0xe8000-0xfffff was already reserved
PnPBIOS: PNP0c01: 0x100000-0x70ffbff was already reserved
PnPBIOS: PNP0c02: 0xdc000-0xdffff was already reserved
PnPBIOS: PNP0c02: 0xd1000-0xd3fff was already reserved
Linux NET4.0 for Linux 2.4
...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
