Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTDVQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263261AbTDVQy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:54:27 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:43915
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S263260AbTDVQyV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:54:21 -0400
Date: Tue, 22 Apr 2003 19:09:35 +0200 (CEST)
Message-Id: <20030422.190935.276777773.rene.rebe@gmx.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: -9.9 (---------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1981H5-0006PZ-KG*3ap1nczGoHg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

"all-module" config all compiles fine - except:

In file included from amd74xx.c:29:
amd74xx.h:101: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclared here (not in a function)
amd74xx.h:101: initializer element is not constant
amd74xx.h:101: (near initialization for `amd74xx_chipsets[5].device')
amd74xx.h:109: initializer element is not constant
amd74xx.h:109: (near initialization for `amd74xx_chipsets[5].enablebits[0]')
amd74xx.h:109: initializer element is not constant
amd74xx.h:109: (near initialization for `amd74xx_chipsets[5].enablebits[1]')
amd74xx.h:109: initializer element is not constant
amd74xx.h:109: (near initialization for `amd74xx_chipsets[5].enablebits')
amd74xx.h:112: initializer element is not constant
amd74xx.h:112: (near initialization for `amd74xx_chipsets[5]')
amd74xx.h:115: `PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE' undeclared here (not in a function)
amd74xx.h:115: initializer element is not constant
amd74xx.h:115: (near initialization for `amd74xx_chipsets[6].device')
amd74xx.h:123: initializer element is not constant
amd74xx.h:123: (near initialization for `amd74xx_chipsets[6].enablebits[0]')
amd74xx.h:123: initializer element is not constant
amd74xx.h:123: (near initialization for `amd74xx_chipsets[6].enablebits[1]')
amd74xx.h:123: initializer element is not constant
amd74xx.h:123: (near initialization for `amd74xx_chipsets[6].enablebits')
amd74xx.h:126: initializer element is not constant
amd74xx.h:126: (near initialization for `amd74xx_chipsets[6]')
amd74xx.h:132: initializer element is not constant
amd74xx.h:132: (near initialization for `amd74xx_chipsets[7]')
amd74xx.c:62: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclared here (not in a function)
amd74xx.c:62: initializer element is not constant
amd74xx.c:62: (near initialization for `amd_ide_chips[5].id')
amd74xx.c:62: initializer element is not constant
amd74xx.c:62: (near initialization for `amd_ide_chips[5]')
amd74xx.c:63: `PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE' undeclared here (not in a function)
amd74xx.c:63: initializer element is not constant
amd74xx.c:63: (near initialization for `amd_ide_chips[6].id')
amd74xx.c:63: initializer element is not constant
amd74xx.c:63: (near initialization for `amd_ide_chips[6]')
amd74xx.c:65: initializer element is not constant
amd74xx.c:65: (near initialization for `amd_ide_chips[7]')
amd74xx.c:455: `PCI_DEVICE_ID_NVIDIA_NFORCE_IDE' undeclared here (not in a function)
amd74xx.c:455: initializer element is not constant
amd74xx.c:455: (near initialization for `amd74xx_pci_tbl[5].device')
amd74xx.c:455: initializer element is not constant
amd74xx.c:455: (near initialization for `amd74xx_pci_tbl[5]')
amd74xx.c:456: `PCI_DEVICE_ID_NVIDIA_NFORCE2_IDE' undeclared here (not in a function)
amd74xx.c:456: initializer element is not constant
amd74xx.c:456: (near initialization for `amd74xx_pci_tbl[6].device')
amd74xx.c:456: initializer element is not constant
amd74xx.c:456: (near initialization for `amd74xx_pci_tbl[6]')
amd74xx.c:457: initializer element is not constant
amd74xx.c:457: (near initialization for `amd74xx_pci_tbl[7]')
amd74xx.c:389: warning: `ata66_amd74xx' defined but not used

On: Mon, 21 Apr 2003 15:47:32 -0300 (BRT),
    Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> 
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.

Sincerely,
- René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
