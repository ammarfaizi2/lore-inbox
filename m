Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWGGT70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWGGT70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWGGT70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:59:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50049 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932256AbWGGT7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:59:25 -0400
Message-ID: <44AEBD17.3080107@garzik.org>
Date: Fri, 07 Jul 2006 15:59:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, jamagallon@ono.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	 <20060705234347.47ef2600@werewolf.auna.net>	 <20060705155602.6e0b4dce.akpm@osdl.org>	 <20060706015706.37acb9af@werewolf.auna.net>	 <20060705170228.9e595851.akpm@osdl.org>	 <20060706163646.735f419f@werewolf.auna.net>	 <20060706164802.6085d203@werewolf.auna.net>	 <20060706234425.678cbc2f@werewolf.auna.net>	 <20060706145752.64ceddd0.akpm@osdl.org>	 <1152288168.20883.8.camel@localhost.localdomain>	 <20060707175509.14ea9187@werewolf.auna.net>	 <1152290643.20883.25.camel@localhost.localdomain>	 <20060707093432.571af16e.rdunlap@xenotime.net>	 <1152292196.20883.48.camel@localhost.localdomain>	 <44AE966F.8090506@garzik.org>	 <1152294245.20883.52.camel@localhost.localdomain>	 <44AE9C67.7000204@garzik.org> <1152302613.20883.58.camel@localhost.localdomain>
In-Reply-To: <1152302613.20883.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-07-07 am 13:39 -0400, ysgrifennodd Jeff Garzik:
>> The user doesn't know about soldered bridge chips.  The user knows if he 
>> is plugging a PATA or SATA cable into his controller.
> 
> In which case the pata_ prefix isnt much use because people soldered
> bridge chips onto just about everything in the first SATA rush, before
> they all switched to chips that actually did SATA.

An easy look at pata_*.c seemed to indicate that at least 20 would 
almost certainly remain pata_*.c, maybe even as many as 30.

The circumstances you cite happened, yes, but I think you exaggerate the 
renaming.  Several soldered bridge solutions are already supported by 
libata.

Several do need to be renamed to ata_*.c, though.

	Jeff



