Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbVHTFk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbVHTFk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 01:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbVHTFk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 01:40:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:36320 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750891AbVHTFk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 01:40:28 -0400
Message-ID: <4306C242.6070607@pobox.com>
Date: Sat, 20 Aug 2005 01:40:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Thonke <iogl64nx@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for Silicon Image 3132 SATA II Controller
References: <2de37a4405072115392cfd5470@mail.gmail.com>
In-Reply-To: <2de37a4405072115392cfd5470@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke wrote:
> Hello,
> 
> I've got a new Silicon Image 3132 SATA II host-controller, this one is
> designed along the SATA (II) specification - (Hot-Plug,NCQ,3GB/s
> transfer). This controller is linked to the pci-express bus. I guess
> it operate like the 3124 controller with some addition :-) On the
> Silicon Image website I found some papers for this controller and his
> architecture. It can be found here
> http://www.siliconimage.com/products/product.aspx?id=32&ptid=1
> 
> I can provide a pci-ids for some specific boards if needed...I found
> this controller on some new motherboards Gigabyte's 955X Royal, ABIT
> AW8,ECS PF88 Extreme, TUL,Foxconn and maybe others coming.
> 
> Is it possible to implement this controller to libata: sata_sil
> driver? I also would spend some time to test the driver.

You'll want to try the sata_sil24 driver, which is in the libata-dev.git 
repository, described at http://lkml.org/lkml/2005/8/18/269

	Jeff


