Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVJQMsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVJQMsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVJQMsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:48:47 -0400
Received: from mail.hg.com ([199.79.200.252]:46809 "EHLO mail.hg.com")
	by vger.kernel.org with ESMTP id S932302AbVJQMsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:48:46 -0400
From: "rob" <rob@janerob.com>
To: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       jbarnes@virtuousgeek.org
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Date: Mon, 17 Oct 2005 13:48:11 +0100
Message-Id: <20051017124711.M44026@janerob.com>
In-Reply-To: <20051017024219.08662190.akpm@osdl.org>
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org> <20051017005515.755decb6.akpm@osdl.org> <4353705D.6060809@s5r6.in-berlin.de> <20051017024219.08662190.akpm@osdl.org>
X-Mailer: Open WebMail 2.51 20050228
X-OriginatingIP: 193.220.20.68 (rob)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Oct 2005 02:42:19 -0700, Andrew Morton wrote
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:

> > Earlier forms of the patch do DMI matching:
> > http://marc.theaimsgroup.com/?l=linux1394-devel&m=110790513206094
> > http://www.janerob.com/rob/ts5100/tosh-1394.patch
> > [short-circuited by if (1) at the second URL]
> 
> Rob, can you finish that patch off and send it?

Sorry, I was advised that this should be correctly handled as a pci-quirk
(Jody McIntyre <scjody@modernduck.com>), and subsequently my laptop
motherboard died so I have no way of taking it further.  The responses I got
indicated that the code works as is for the followiung laptops


> System Vendor: TOSHIBA
> Product Name: S5100-501
> Version: PS510E-00NV7-EN


System Vendor: TOSHIBA
Product Name: S5200-801
Version: PS520E-31P1D-GR

Manufacturer: TOSHIBA
Product Name: Satellite 5200
Version: PS520C-31P0EP

Manufacturer: TOSHIBA
Product Name: Satellite 5205
Version: PS522U-XK00YV

Manufacturer: TOSHIBA
Product Name: S5100-603
Version: PS511E-05328-GR

toshiba satellite 5005-S504

Toshiba Satellite 5105-s607


rob.


--
Open WebMail Project (http://openwebmail.org)



