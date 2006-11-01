Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992515AbWKAOiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992515AbWKAOiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992511AbWKAOiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:38:21 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:65468 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S2992514AbWKAOiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:38:20 -0500
Subject: Re: [git patches] libata fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <17736.43507.649685.484648@smtp.charter.net>
References: <20061101021301.GA21568@havoc.gtf.org>
	 <17736.43507.649685.484648@smtp.charter.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 14:30:35 +0000
Message-Id: <1162391435.11965.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-01 am 09:06 -0500, ysgrifennodd John Stoffel:
> Jeff> +	{ 0x8086, 0x7110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> Jeff>  	{ 0x8086, 0x7111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, piix_pata_33 },
> 
> Umm, according to lspci -nn on my 440GX box, isn't the 0x8086/0x7110
> an ISA bridge, not a PIIX? controller?  

Correct - the 7110 doesn't belong on that list.


