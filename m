Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbQLLDPD>; Mon, 11 Dec 2000 22:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131003AbQLLDOn>; Mon, 11 Dec 2000 22:14:43 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:54279 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130499AbQLLDOi>;
	Mon, 11 Dec 2000 22:14:38 -0500
To: davej@suse.de
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, Martin Mares <mj@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <Pine.LNX.4.21.0012110018180.19534-100000@neo.local>
From: Jes Sorensen <jes@linuxcare.com>
Date: 12 Dec 2000 03:43:52 +0100
In-Reply-To: davej@suse.de's message of "Mon, 11 Dec 2000 00:34:54 +0000 (GMT)"
Message-ID: <d31yvemk9j.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dave" == davej  <davej@suse.de> writes:

Dave> On Mon, 11 Dec 2000, Jamie Lokier wrote:
>> Here are a few more:
>> 
>> net/acenic.c: pci_write_config_byte(ap->pdev, PCI_CACHE_LINE_SIZE,

Dave> Acenic is at least setting it to the correct values, not
Dave> hardcoding it.

Nod, it's important that it is set to the right value rather than some
random hardcoded noise. I had to add it to the AceNIC driver as I had
a motherboard that didn't set it correctly on all PCI slots.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
