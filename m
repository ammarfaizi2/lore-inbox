Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424164AbWKPP1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424164AbWKPP1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424165AbWKPP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:27:18 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:9917 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1424164AbWKPP1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:27:17 -0500
Message-ID: <455C8350.3050309@garzik.org>
Date: Thu, 16 Nov 2006 10:27:12 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <455A938A.4060002@garzik.org>	<20061114.201549.69019823.davem@davemloft.net>	<455A9664.50404@garzik.org>	<20061114.202814.70218466.davem@davemloft.net>	<1163643937.5940.342.camel@localhost.localdomain>	<455BDA1D.5090409@garzik.org>	<1163650341.5940.361.camel@localhost.localdomain>	<455C0176.5090107@garzik.org> <m3u00z4fnv.fsf@defiant.localdomain>
In-Reply-To: <m3u00z4fnv.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> OTOH many devices have "interrupt disable" bit somewhere else, in
> their specific PCI config registers or in regular config registers
> (accessible with normal Memory Read/Write cycles).

Most interrupt-driven devices have an interrupt mask register of some 
sort.  The nice thing about PCI_COMMAND_INTX_DISABLE is that it is 
standardized.

	Jeff


