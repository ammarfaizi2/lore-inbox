Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966030AbWKNPnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966030AbWKNPnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 10:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966042AbWKNPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 10:43:53 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57536 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966030AbWKNPnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 10:43:52 -0500
Message-ID: <4559E432.9070401@pobox.com>
Date: Tue, 14 Nov 2006 10:43:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: netdev@vger.kernel.org, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH take 2] Atmel MACB ethernet driver
References: <20061109145117.577e3c61@cad-250-152.norway.atmel.com>
In-Reply-To: <20061109145117.577e3c61@cad-250-152.norway.atmel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haavard Skinnemoen wrote:
> Driver for the Atmel MACB on-chip ethernet module.
> 
> Tested on AVR32/AT32AP7000/ATSTK1000. I've heard rumours that it works
> with AT91SAM9260 as well, and it may be possible to share some code with
> the at91_ether driver for AT91RM9200.
> 
> Hardware documentation can be found in the AT32AP7000 data sheet,
> which can be downloaded from
> 
> http://www.atmel.com/dyn/products/datasheets.asp?family_id=682
> 
> Changes since previous version:
>   * Probe for PHY ID instead of depending on it being provided through
>     platform_data.
>   * Grab initial ethernet address from the MACB registers instead
>     of depending on platform_data.
>   * Set MII/RMII mode correctly.
> 
> These changes are mostly about making the driver more compatible with
> the at91 infrastructure.
> 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

applied.

Thanks for submitting a nice, clean driver that was so painless to apply 
to the latest kernel.

I wish all vendors were as effective and efficient.

	Jeff



