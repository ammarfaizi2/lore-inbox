Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVAES54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVAES54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262555AbVAES54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:57:56 -0500
Received: from vvtp.tn.tudelft.nl ([130.161.252.29]:19856 "HELO
	vvtp.tudelft.nl") by vger.kernel.org with SMTP id S262546AbVAES5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:57:54 -0500
Date: Wed, 5 Jan 2005 19:57:33 +0100
From: Konrad Wojas <wojas@vvtp.tudelft.nl>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 oops in poll()?
Message-ID: <20050105185733.GJ31250@vvtp.tudelft.nl>
References: <20050103161556.GD31250@vvtp.tudelft.nl> <41DB1C92.7060501@osdl.org> <20050105040841.GI31250@vvtp.tudelft.nl> <41DC30C9.5050402@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DC30C9.5050402@osdl.org>
X-Detect-Self: dd61600cfe762340a29ea869157aecee
User-Agent: Mutt/1.5.6+20040907i
X-AntiVirus: scanned on vvtp.tudelft.nl for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 10:24:09AM -0800, Randy.Dunlap wrote:
> This probably needed to use /proc/kallsyms from the dying kernel,
> which you most likely don't have....
> 
> I'm having trouble seeing what sock_poll() called (i.e., where EIP
> register points to).  In the /boot/System.map-2.6.9-1-686 file,
> is anything near address 0xc02b5513 listed?
> (or just send me that file privately)

Also doesn't look very helpfull to me..

c02a592a r __func__.1
c02a593b r __func__.0
c02a594c r __func__.8
c02a5960 r llc_oui
c02a59a8 r __func__.4
c02c6bc8 d __pci_fixup_PCI_VENDOR_ID_S3PCI_DEVICE_ID_S3_868quirk_s3_64M
c02c6bc8 D __start_pci_fixups_header
c02c6bd0 d __pci_fixup_PCI_VENDOR_ID_S3PCI_DEVICE_ID_S3_968quirk_s3_64M
c02c6bd8 d __pci_fixup_PCI_VENDOR_ID_ALPCI_DEVICE_ID_AL_M7101quirk_ali7101_acpi
c02c6be0 d __pci_fixup_PCI_VENDOR_ID_INTELPCI_DEVICE_ID_INTEL_82371AB_3quirk_piix4_acpi

-- 
Konrad Wojas                          .~.
~  wojas@vvtp.tudelft.nl             / V \
~                                   /(   )\
:wq       GnuPG key 0x588C85B1        ^ ^

