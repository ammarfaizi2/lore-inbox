Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKRGsX>; Sat, 18 Nov 2000 01:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130697AbQKRGsD>; Sat, 18 Nov 2000 01:48:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12037 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129659AbQKRGsB>;
	Sat, 18 Nov 2000 01:48:01 -0500
Message-ID: <3A161F16.89206974@mandrakesoft.com>
Date: Sat, 18 Nov 2000 01:17:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sound and scsi pci MODULE_DEVICE_TABLE entries? (primary for Alan 
 Cox)
In-Reply-To: <200011180601.WAA01562@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> Hello Alan,
> 
>         Jeff Garzik tells me that you, with some help from some other
> kernel developers, are hacking on the sound drivers right now.  I
> would like to add PCI MODULE_DEVICE_TABLE entries to three of
> the four PCI sound drivers: cmpci, cs46xx and nm256_audio.
> (I have already sent a similar patch to Zach Brown for maestro,
> although that was a port to the new PCI interface.)  This will
> enable depmod to record the PCI ID's that they care about in
> /lib/modules/<version>/modules.pcimap, which, in turn, will
> enable more automated module loading based on hardware configuration.

I responded to Adam in private, but wanted to speak up in public too: 
these changes sound ok with me.  The patches change no code logic, they
export the supported PCI ids to userspace, and make the transition to
the new PCI API a tiny bit easier.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
