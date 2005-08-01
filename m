Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVHAOoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVHAOoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVHAOmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:42:08 -0400
Received: from [81.103.221.47] ([81.103.221.47]:549 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262219AbVHAOl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:41:59 -0400
Message-ID: <42EE3501.7010107@gentoo.org>
Date: Mon, 01 Aug 2005 15:43:13 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Otto Meier <gf435@gmx.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net>
In-Reply-To: <42EDE918.9040807@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Meier wrote:
> This card use the sata chip pdc 40718 (as of my card)
> the lastest sata_promise kernel with sata promise patch driver doesn't 
> recognise
> this card.
> 
> I added the following line to static struct pci_device_id 
> pdc_ata_pci_tbl[]  in sata_promise.c:
> 
>        { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>          board_20319 },
> 
> and the card was recognised and seam to work without errors so far.

Yes, this should be fine (this is a 4-port SATA card right?)

Are you happy to produce and submit a patch yourself (read 
Documentation/SubmittingPatches) or should I submit one for you?

Thanks,
Daniel
