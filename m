Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUI0VFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUI0VFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUI0VDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:03:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:60565 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267381AbUI0VCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:02:01 -0400
Subject: 2.6.9-rc2-mm4 PPC fixes ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1096318541.3628.440.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Sep 2004 13:55:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

Any fixes to make PPC64 work on 2.6.9-rc2-mm4 ?
I get following compile errors. Please let me know.

Thanks,
Badari

arch/ppc64/kernel/pSeries_pci.o(.text+0x708): In function
`.pcibios_fixup_bus':
: multiple definition of `.pcibios_fixup_bus'
arch/ppc64/kernel/pci.o(.text+0x544): first defined here
ld: Warning: size of symbol `.pcibios_fixup_bus' changed from 456 in
arch/ppc64/kernel/pci.o to 464 in arch/ppc64/kernel/pSeries_pci.o
arch/ppc64/kernel/pSeries_pci.o(.opd+0x0): In function
`pcibios_fixup_device_resources':
: multiple definition of `pcibios_fixup_device_resources'
arch/ppc64/kernel/pci.o(.opd+0xa8): first defined here
arch/ppc64/kernel/pSeries_pci.o(*ABS*+0xe894883f): In function
`__crc_pcibios_fixup_device_resources':
pSeries_pci.c: multiple definition of
`__crc_pcibios_fixup_device_resources'
arch/ppc64/kernel/pSeries_pci.o(*ABS*+0xe2e88e3e): In function
`__crc_pcibios_fixup_bus':
pSeries_pci.c: multiple definition of `__crc_pcibios_fixup_bus'
arch/ppc64/kernel/pSeries_pci.o(.text+0x0): In function
`.pcibios_fixup_device_resources':
: multiple definition of `.pcibios_fixup_device_resources'
arch/ppc64/kernel/pci.o(.text+0x188): first defined here
arch/ppc64/kernel/pSeries_pci.o(.opd+0xa8): In function
`pcibios_fixup_bus':
: multiple definition of `pcibios_fixup_bus'
arch/ppc64/kernel/pci.o(.opd+0x150): first defined here
make[1]: *** [arch/ppc64/kernel/built-in.o] Error 1
make: *** [arch/ppc64/kernel] Error 2
make: *** Waiting for unfinished jobs....
make: *** wait: No child processes.  Stop.


