Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUGFQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUGFQVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 12:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUGFQVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 12:21:36 -0400
Received: from c3-1d224.neo.lrun.com ([24.93.233.224]:12164 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S264097AbUGFQVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 12:21:34 -0400
Date: Tue, 6 Jul 2004 12:17:32 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: caszonyi@rdslink.ro
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm[3-4] doesn't boot (alsa or pnp related)
Message-ID: <20040706121732.GA3150@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, caszonyi@rdslink.ro,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0406300333020.216@grinch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0406300333020.216@grinch.ro>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 03:40:43AM +0300, caszonyi@rdslink.ro wrote:
> Hi all
> I just tried today 2.6.7-mm3 and 2.6.7-mm4.
> They both stop booting at:
> Advanced Linux Sound Architecture Driver Version 1.0.5 (Sun May 30
> 10:49:40 2004 UTC)
> pnp: Device 01:01.00 activated
> pnp: Device 01:01.02 activated
> pnp: Device 01:01.03 activated
>
> 
> on a normal boot it is (vanila 2.6.7):
>
> Advanced Linux Sound Architecture Driver Version 1.0.4 (Mon May 17
> 14:31:44 2004 U
> TC).
> pnp: the driver 'cs423x' has been registered
> pnp: match found with the PnP device '01:01.00' and the driver 'cs423x'
> pnp: match found with the PnP device '01:01.02' and the driver 'cs423x'
> pnp: match found with the PnP device '01:01.03' and the driver 'cs423x'
> pnp: Device 01:01.00 activated.
> pnp: Device 01:01.02 activated.
> pnp: Device 01:01.03 activated.
> ALSA device list:
>   #0: CS4239 at 0x534, irq 5, dma 1&0
>   #1: Brooktree Bt878 at 0xe2002000, irq 10
>
> config is attached
>
> Bye
> Calin

This may be a resource conflict.  Do you have an isapnp modem?  If so, try
disabling the serial driver.

Thanks,
Adam
