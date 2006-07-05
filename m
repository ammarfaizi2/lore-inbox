Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWGESJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWGESJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWGESJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:09:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33426 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964956AbWGESJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:09:25 -0400
Message-ID: <44AC0053.6050605@garzik.org>
Date: Wed, 05 Jul 2006 14:09:23 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Narendra Hadke <nhadke@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: sata_mv driver on 88sx6041 ( 2.6.14): PCI IRQ error
References: <20060705174826.60724.qmail@web33508.mail.mud.yahoo.com>
In-Reply-To: <20060705174826.60724.qmail@web33508.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Narendra Hadke wrote:
> Jeff, 
>  Really apreciate your help on this.
>    How this works for PIO mode? SATA Disk looks 
>  perfectly visible in PIO mode. The problem is when I
>  go to DMA mode.
>   Is this problem specific to DMA mode?

PIO is far slower, and is unlikely to stress the PCI bus enough to 
trigger hardware problems.

	Jeff



