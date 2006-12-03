Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759657AbWLCNHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759657AbWLCNHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759662AbWLCNHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:07:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:30669 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1759656AbWLCNHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:07:48 -0500
Message-ID: <4572CC22.4050303@garzik.org>
Date: Sun, 03 Dec 2006 08:07:46 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19 3/3] sata_promise: cleanups
References: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
In-Reply-To: <200612010959.kB19xmAw002464@alkaid.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> This patch performs two simple cleanups of sata_promise.
> 
> * Remove board_20771 and map device id 0x3577 to board_2057x.
>   After the recent corrections for SATAII chips, board_20771 and
>   board_2057x were equivalent in the driver.
> 
> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>   to compute hotplug_offset in pdc_host_init().
> 
> This patch depends on the sata_promise SATAII updates
> patch I sent recently.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

ACK, but not applied:

patch #2 (presumably this patches depends on it) probably needs revision 
(see Tejun's comments).

feel free to resend this patch against #upstream, while revising patch #2

	Jeff



