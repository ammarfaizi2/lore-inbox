Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbRBXSgz>; Sat, 24 Feb 2001 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129544AbRBXSgq>; Sat, 24 Feb 2001 13:36:46 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:33551 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S129541AbRBXSgk>;
	Sat, 24 Feb 2001 13:36:40 -0500
Message-Id: <200102241836.LAA27025@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
cc: Philipp Rumpf <prumpf@mandrakesoft.com>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x 
In-Reply-To: Your message of Sat, 24 Feb 2001 11:55:07 CST.
In-Reply-To: <200102240941.CAA09708@ibg.colorado.edu> <Pine.LNX.4.10.10102240532030.30331-100000@penguin.transmeta.com> <20010224095447.A28983@mandrakesoft.mandrakesoft.com> <200102241725.KAA19514@ibg.colorado.edu> <20010224115507.B28983@mandrakesoft.mandrakesoft.com> 
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 8063
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Sat, 24 Feb 2001 11:36:39 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In your message of: Sat, 24 Feb 2001 11:55:07 CST, you write:
>
>Careful, you're overwriting ACPI data now (and using it as normal RAM).

Hmm, I guess that would be bad.

>Can you try one of a) LILO b) a fixed version of grub c) this patch ?

I tried LILO and the problem did indeed go away when using that.  I
guess I'll stick with LILO until Linux or grub (whichever is broken)
is fixed.  There is just something appealing about a proper boot
console on a PC...

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009f800 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000800 @ 000000000009f800 (reserved)
 BIOS-e820: 0000000000019800 @ 00000000000e6800 (reserved)
 BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000fc00 @ 0000000013ff0000 (ACPI data)
 BIOS-e820: 0000000000000400 @ 0000000013fffc00 (ACPI NVS)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
On node 0 totalpages: 81904
zone(0): 4096 pages.
zone(1): 77808 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
