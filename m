Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUFBJ4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUFBJ4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 05:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUFBJ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 05:56:25 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:1796 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S261426AbUFBJ4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 05:56:23 -0400
Date: Wed, 2 Jun 2004 11:56:02 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Intel 875 Motherboard cant use 4GB of Memory.
Message-ID: <20040602095602.GA23680@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <200406011956.i51JuYkD019999@orion.dwf.com> <200406012010.i51KAuWP024552@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406012010.i51KAuWP024552@turing-police.cc.vt.edu>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu>
Date: Tue, Jun 01, 2004 at 04:10:56PM -0400
> There's 3 basic directions you can go:  (1) find a way to disambiguate the
> memory addresses so shadowing isn't a problem (probably not an option), (2a)
> find a way to relocate the reserved stuff above the 4G address line (probably
> need BIOS assistance for this), or (2b) find a way to relocate a gig and a half
> or so of memory above the 4G linem or (3) Move to an architecture that isn't
> constrained by 32-bit addresses...
> 
Option 4: move to another i875 motherboard. This is an Epox 4PCA3+,
which at least with 3 Gb has no problems:

Linux version 2.6.7-rc2 (jurriaan@middle) (gcc version 3.3.3 (Debian 20040422)) #2 SMP Mon May 31 10:25:04 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
 BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5900
On node 0 totalpages: 786416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 557040 pages, LIFO batch:16
DMI 2.2 present.
Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-32@85 softrepeat=1
Memory: 3113796k/3145664k available (3494k kernel code, 30720k reserved, 1460k data, 504k init, 2228160k highmem)

Good luck,
Jurriaan
-- 
hundred-and-one symptoms of being an internet addict:
17. You turn on your intercom when leaving the room so you can hear if new
e-mail arrives.
Debian (Unstable) GNU/Linux 2.6.7-rc2 2x6062 bogomips load 0.13
