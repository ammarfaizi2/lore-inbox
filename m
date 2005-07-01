Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbVGATJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbVGATJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbVGATJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:09:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21173 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263435AbVGATJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:09:22 -0400
Date: Fri, 1 Jul 2005 21:09:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: christos gentsis <christos_gentsis@yahoo.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-X support
Message-ID: <20050701190939.GA2154@ucw.cz>
References: <42C58203.40606@yahoo.co.uk> <Pine.LNX.4.61.0507011357290.5350@chaos.analogic.com> <42C585CE.1060509@yahoo.co.uk> <Pine.LNX.4.61.0507011453380.4921@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507011453380.4921@chaos.analogic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 03:02:11PM -0400, Richard B. Johnson wrote:

> The driver (whatever that is), if it was written for a 64-bit
> platform, can write a 64-bit word in one operation and it's
> transparent. If the driver was written for a 32-bit environment,
> it will still work because there is compatibility with PCI 2.x
> 
> FYI, this machine has a PCI-X bus. I have some 32-bit cards
> plugged into it (SCSI controller, etc.). They work. I also
> have a 64-bit card plugged into it (fiber-optic data link).
> It also works, but at 133 MHz. Software never talks to it
> in 'long longs' so the increased data-width isn't being used.

Are you sure about that? I'd assume when doing busmastering, it'll use
64-bit transfers, if the driver sets the correct DMA mask.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
