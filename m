Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWGGVMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWGGVMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWGGVME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:12:04 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44931 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932280AbWGGVMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:12:01 -0400
Message-ID: <44AECE1B.5020502@garzik.org>
Date: Fri, 07 Jul 2006 17:11:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<20060705155602.6e0b4dce.akpm@osdl.org>	<20060706015706.37acb9af@werewolf.auna.net>	<20060705170228.9e595851.akpm@osdl.org>	<20060706163646.735f419f@werewolf.auna.net>	<20060706164802.6085d203@werewolf.auna.net>	<20060706234425.678cbc2f@werewolf.auna.net>	<20060706145752.64ceddd0.akpm@osdl.org>	<1152288168.20883.8.camel@localhost.localdomain>	<20060707175509.14ea9187@werewolf.auna.net>	<1152290643.20883.25.camel@localhost.localdomain>	<20060707093432.571af16e.rdunlap@xenotime.net>	<1152292196.20883.48.camel@localhost.localdomain>	<44AE966F.8090506@garzik.org>	<1152294245.20883.52.camel@localhost.localdomain>	<44AE9C67.7000204@garzik.org>	<1152302613.20883.58.camel@localhost.localdomain>	<44AEBD17.3080107@garzik.org>	<1152303822.20883.74.camel@localhost.localdomain>	<44AEC0BF.7090504@garzik.org>	<1152304961.20883.80.camel@localhost.localdomain>	<44AEC618.8040001@garzik.org> <20060707230922.7c8739a1@werewolf.auna.net>
In-Reply-To: <20060707230922.7c8739a1@werewolf.auna.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallón wrote:
> for each controller
> 	sata_init
> for each controller
> 	pata_init


There is never a 'for each controller' operation.

The current layering is as it should be.

	Jeff


