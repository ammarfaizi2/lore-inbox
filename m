Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269875AbUJHA0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269875AbUJHA0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUJHAXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:23:53 -0400
Received: from CPE-203-51-28-190.nsw.bigpond.net.au ([203.51.28.190]:4080 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S269940AbUJHAUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:20:03 -0400
Message-ID: <4165DD2C.1050209@eyal.emu.id.au>
Date: Fri, 08 Oct 2004 10:19:56 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6 noisy boot messages from gen_probe.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this stuff at bootup, and I do not see why it should
interest me. Normally one wants to see only detected devices
and not failed probes. I did not enable any debug option
in the kernel.

It seems to come from
	mtd/chips/gen_probe.c
I do have
	CONFIG_MTD_ICHXROM=m
because I build all modules. So, should these printk's really
be KERN_WARNING or should they be removed?

Oct  8 09:58:45 eyal kernel: hub 5-0:1.0: 8 ports detected
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: hub 5-0:1.0: 8 ports detected
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: CFI: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: Support for command set 8007 not present
Oct  8 09:58:45 eyal kernel: Support for command set 007F not present
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Oct  8 09:58:45 eyal kernel: Support for command set 8007 not present
Oct  8 09:58:45 eyal kernel: Support for command set 007F not present
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: JEDEC: Found no ichxrom device at location zero
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: Support for command set 8007 not present
Oct  8 09:58:45 eyal kernel: Support for command set 007F not present
Oct  8 09:58:45 eyal kernel: gen_probe: No supported Vendor Command Set found
Oct  8 09:58:45 eyal kernel: Found: SST 49LF004B
Oct  8 09:58:45 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Oct  8 09:58:45 eyal kernel: number of JEDEC chips: 1

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
