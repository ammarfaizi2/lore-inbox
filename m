Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965215AbWFTIvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215AbWFTIvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWFTIvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:51:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:65479 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965215AbWFTIvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:51:31 -0400
Message-ID: <4497B711.30109@garzik.org>
Date: Tue, 20 Jun 2006 04:51:29 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Marc Sowen <marc.sowen@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] com20020_cs, kernel 2.6.17-rc6, 3rd try
References: <4490281B.5060801@gmx.net>
In-Reply-To: <4490281B.5060801@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Sowen wrote:
> Hello everybody,
> 
> this patch enables the com20020_cs arcnet driver to see the SoHard (now 
> Mercury Computer Systems Inc.) SH ARC-PCMCIA card. Added signed off line.
> 
> Regards,
>  Marc
> 
> Signed-off-by: Marc Sowen <marc.sowen@ibeo-as.de>
> 
> --- a/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-06 
> 02:57:02.000000000 +0200
> +++ b/linux-2.6.17-rc6/drivers/net/pcmcia/com20020_cs.c 2006-06-13 
> 17:10:03.000000000 +0200
> @@ -388,6 +388,7 @@
> 
>  static struct pcmcia_device_id com20020_ids[] = {
>         PCMCIA_DEVICE_PROD_ID12("Contemporary Control Systems, Inc.", 
> "PCM20 Arcnet Adapter", 0x59991666, 0x95dfffaf),
> +       PCMCIA_DEVICE_PROD_ID12("SoHard AG", "SH ARC PCMCIA", 
> 0xf8991729, 0x69dff0c7),
>         PCMCIA_DEVICE_NULL

ACK, but patch is corrupted:

Applying 'com20020_cs, kernel 2.6.17-rc6, 3rd try'

fatal: corrupt patch at line 4

