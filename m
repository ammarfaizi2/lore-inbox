Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSAQNOm>; Thu, 17 Jan 2002 08:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSAQNOe>; Thu, 17 Jan 2002 08:14:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49168 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S288677AbSAQNOY>;
	Thu, 17 Jan 2002 08:14:24 -0500
Message-ID: <3C46CE28.853C6BE7@mandrakesoft.com>
Date: Thu, 17 Jan 2002 08:14:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Jeremy Freeman <jfreeman@sporg.com>, linux-kernel@vger.kernel.org
Subject: Re: XP PCI Contamination, GURR (Re: Care?)
In-Reply-To: <Pine.LNX.4.10.10201170438020.30663-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> It appears the folks up in redmond have succeeded in having the BIOS
> people default disable PCI resources.  Since XP will reject, or assume a
> device is in use should the BAR's be allocated, the various archs may need
> to have a broader setup table or a more generic ruleset.
> 
> Any thoughts on how best to address good hardare, which the BIOS does not
> setup per redmond-rules.

pci_enable_enable, pci_set_master, and all the tools that the kernel
already provides...

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
