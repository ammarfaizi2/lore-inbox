Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWGGUhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWGGUhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWGGUhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 16:37:51 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59010 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751246AbWGGUhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 16:37:50 -0400
Message-ID: <44AEC618.8040001@garzik.org>
Date: Fri, 07 Jul 2006 16:37:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, jamagallon@ono.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	 <20060705234347.47ef2600@werewolf.auna.net>	 <20060705155602.6e0b4dce.akpm@osdl.org>	 <20060706015706.37acb9af@werewolf.auna.net>	 <20060705170228.9e595851.akpm@osdl.org>	 <20060706163646.735f419f@werewolf.auna.net>	 <20060706164802.6085d203@werewolf.auna.net>	 <20060706234425.678cbc2f@werewolf.auna.net>	 <20060706145752.64ceddd0.akpm@osdl.org>	 <1152288168.20883.8.camel@localhost.localdomain>	 <20060707175509.14ea9187@werewolf.auna.net>	 <1152290643.20883.25.camel@localhost.localdomain>	 <20060707093432.571af16e.rdunlap@xenotime.net>	 <1152292196.20883.48.camel@localhost.localdomain>	 <44AE966F.8090506@garzik.org>	 <1152294245.20883.52.camel@localhost.localdomain>	 <44AE9C67.7000204@garzik.org>	 <1152302613.20883.58.camel@localhost.localdomain>	 <44AEBD17.3080107@garzik.org>	 <1152303822.20883.74.camel@localhost.localdomain>	 <44AEC0BF.7090504@garzik.org> <1152304961.20883.80.camel@localhost.localdomain>
In-Reply-To: <1152304961.20883.80.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Gwe, 2006-07-07 am 16:14 -0400, ysgrifennodd Jeff Garzik:
>> I'm a bit surprised to see pata_sis and pata_via:  are you certain there 
>> is not confusion based on the fact that newer SiS, ULi and VIA 
>> controllers provide both SATA and PATA on the same controller?
> 
> Hard to be sure but it looks like some vendors briefly used marvell
> bridges of some form with a few generic PATA chipsets.

Yep.  The sata_xxx should cover most of the Marvell-SATA-bridge + PATA 
chip controllers already.

Pretty much everybody except Silicon Image used the Marvell bridge for 
their first generation SATA.

I've tried hard to make sure that most of these made it into sata_xxx 
already.

	Jeff



