Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269530AbUJFVxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269530AbUJFVxe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUJFVuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:50:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36586 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S269530AbUJFVtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:49:19 -0400
Subject: 2.6.9-rc3-mm2 compile problems on ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1097098866.12861.219.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Oct 2004 14:41:06 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't build 2.6.9-rc3-mm2 on ppc64. Any fixes ?

Thanks,
Badari
 

 LD      arch/ppc64/kernel/built-in.o
arch/ppc64/kernel/pSeries_pci.o(.text+0x9fc): In function
`pcibios_fixup_bus':
arch/ppc64/kernel/pSeries_pci.c:508: multiple definition of
`.pcibios_fixup_bus'
arch/ppc64/kernel/pci.o(.text+0x540):arch/ppc64/kernel/pci.c:815: first
defined
here
ld: Warning: size of symbol `.pcibios_fixup_bus' changed from 456 in
arch/ppc64/
kernel/pci.o to 464 in arch/ppc64/kernel/pSeries_pci.o
arch/ppc64/kernel/pSeries_pci.o(.opd+0x0): In function
`pcibios_fixup_device_res
ources':
: multiple definition of `pcibios_fixup_device_resources'
arch/ppc64/kernel/pci.o(.opd+0x90):arch/ppc64/kernel/pci.c:157: first
defined he
re
arch/ppc64/kernel/pSeries_pci.o(*ABS*+0x27fc96b4): In function
`__crc_pcibios_fi
xup_device_resources':
pSeries_pci.c: multiple definition of
`__crc_pcibios_fixup_device_resources'
arch/ppc64/kernel/pSeries_pci.o(*ABS*+0x212b253a): In function
`__crc_pcibios_fi
xup_bus':
pSeries_pci.c: multiple definition of `__crc_pcibios_fixup_bus'
arch/ppc64/kernel/pSeries_pci.o(.text+0x0): In function
`.pcibios_fixup_device_r
esources':
: multiple definition of `.pcibios_fixup_device_resources'
arch/ppc64/kernel/pci.o(.text+0x184):arch/ppc64/kernel/pci.c:781: first
defined
here
arch/ppc64/kernel/pSeries_pci.o(.opd+0xf0): In function
`pSeries_final_fixup':
arch/ppc64/kernel/pSeries_pci.c:477: multiple definition of
`pcibios_fixup_bus'
arch/ppc64/kernel/pci.o(.opd+0x138):arch/ppc64/kernel/pci.c:743: first
defined h
ere
make[1]: *** [arch/ppc64/kernel/built-in.o] Error 1
make: *** [arch/ppc64/kernel] Error 2
make: *** Waiting for unfinished jobs....


