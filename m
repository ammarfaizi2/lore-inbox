Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTHYDXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 23:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTHYDXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 23:23:07 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:53397 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261427AbTHYDXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 23:23:04 -0400
Date: Mon, 25 Aug 2003 04:50:49 +0200 (CEST)
From: Aschwin Marsman <aschwin@marsman.org>
X-X-Sender: marsman@localhost.localdomain
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-rc3 (retry)
Message-ID: <Pine.LNX.4.44.0308250447370.1837-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Retry, the mail that I sent yesterday didn't appear on the list...

On Sat, 23 Aug 2003, Marcelo Tosatti wrote:

> Hi,

Hi,
 
> Here goes -rc3, with several fixes. The ACPI changes should fix most of
> well known ACPI issues: Please test it.

ACPI was working well (powerdown) until 2.4.22-rc2 but was disabled for my 
bios in 2.4.22-rc3 because of the date of the bios. By using the suggested 
acpi=force powerdown works again.

Is there a list of known broken/working BIOS versions, because the bios
for the ASUS CUBX-L is working (for my use of ACPI)?

Aug 24 05:29:40 quinten kernel: ACPI disabled because your bios is from 2000 and too old
Aug 24 05:29:40 quinten kernel: You can enable it with acpi=force
Aug 24 05:29:40 quinten kernel: ACPI: RSDP (v000 ASUS                                      ) @ 0x000f5a90
Aug 24 05:29:40 quinten kernel: ACPI: RSDT (v001 ASUS   CUBX-L   0x30303031 MSFT 0x31313031) @ 0x3ffec000
Aug 24 05:29:40 quinten kernel: ACPI: FADT (v001 ASUS   CUBX-L   0x30303031 MSFT 0x31313031) @ 0x3ffec080
Aug 24 05:29:40 quinten kernel: ACPI: BOOT (v001 ASUS   CUBX-L   0x30303031 MSFT 0x31313031) @ 0x3ffec040
Aug 24 05:29:40 quinten kernel: ACPI: DSDT (v001   ASUS CUBX-L   0x00001000 MSFT 0x0100000b) @ 0x00000000

> This is the last -rc I hope.

Everything is working as aspected, nothing prevents me from living on
the edge.
 
> Detailed changelog below
> 
> Summary of changes from v2.4.22-rc2 to v2.4.22-rc3
> ============================================
> 
> <len.brown:intel.com>:
>   o ACPI update
>   o ACPI build fix
>   o linux-acpi-2.4.22.patch
 
Have fun & a nice weekend,
 
Aschwin Marsman
 
--
aschwin@marsman.org              http://www.marsman.org


