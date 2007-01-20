Return-Path: <linux-kernel-owner+w=401wt.eu-S932860AbXATAMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860AbXATAMv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbXATAMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:12:51 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53716 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617AbXATAMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:12:50 -0500
Message-ID: <45B15E7F.1080005@garzik.org>
Date: Fri, 19 Jan 2007 19:12:47 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc4] sata_promise: ATAPI cleanup
References: <200701100832.l0A8WYat017411@harpo.it.uu.se>
In-Reply-To: <200701100832.l0A8WYat017411@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Here's a cleanup for yesterday's sata_promise ATAPI patch:
> - add and use a symbolic constant for the altstatus register
> - check return status from ata_busy_wait()
> - add missing newline in a warning printk()
> - update comment in pdc_issue_atapi_pkt_cmd() to clarify
>   that the maybe-wait-for-INT issue cannot occur in the
>   current driver, but may occur if the driver starts issuing
>   ATAPI non-DMA commands as PDC packets
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied


