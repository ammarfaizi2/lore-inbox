Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWGGUGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWGGUGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWGGUGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:06:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59858 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932307AbWGGUGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:06:17 -0400
Subject: Re: 2.6.17-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, jamagallon@ono.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44AEBD17.3080107@garzik.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	 <20060705234347.47ef2600@werewolf.auna.net>
	 <20060705155602.6e0b4dce.akpm@osdl.org>
	 <20060706015706.37acb9af@werewolf.auna.net>
	 <20060705170228.9e595851.akpm@osdl.org>
	 <20060706163646.735f419f@werewolf.auna.net>
	 <20060706164802.6085d203@werewolf.auna.net>
	 <20060706234425.678cbc2f@werewolf.auna.net>
	 <20060706145752.64ceddd0.akpm@osdl.org>
	 <1152288168.20883.8.camel@localhost.localdomain>
	 <20060707175509.14ea9187@werewolf.auna.net>
	 <1152290643.20883.25.camel@localhost.localdomain>
	 <20060707093432.571af16e.rdunlap@xenotime.net>
	 <1152292196.20883.48.camel@localhost.localdomain>
	 <44AE966F.8090506@garzik.org>
	 <1152294245.20883.52.camel@localhost.localdomain>
	 <44AE9C67.7000204@garzik.org>
	 <1152302613.20883.58.camel@localhost.localdomain>
	 <44AEBD17.3080107@garzik.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 21:23:42 +0100
Message-Id: <1152303822.20883.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 15:59 -0400, ysgrifennodd Jeff Garzik:
> The circumstances you cite happened, yes, but I think you exaggerate the 
> renaming.  Several soldered bridge solutions are already supported by 
> libata.
> 
> Several do need to be renamed to ata_*.c, though.

If we work on the "commonly found" basis then it would be

pata_atiixp
pata_hpt37x
pata_hpt3x2n
pata_pdc2027x

All four commonly are found with SATA bridges, ATIIXP especially.

On the "almost any obscure case basis" would add

pata_ali
pata_sis
pata_via

and depending how far pushed

pata_sil680

and one or two others

Which do you want renamed ?

